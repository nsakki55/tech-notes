import os.path as osp
import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
from PIL import Image
from utils.data_augumentation import Compose, Scale, RandomRotation, RandomMirror, Resize, Normalize_Tensor
import random, math, time

import torch
import torch.utils.data as data
import torch.nn as nn
import torch.nn.functional as F
import torch.nn.init as init
import torch.optim as optim
from PSPNet import PSPNet
from dataset import make_datapath_list, DataTransform, VOCDataset

# 初期設定
# Setup seeds
torch.manual_seed(1234)
np.random.seed(1234)
random.seed(1234)


class PSPLoss(nn.Module):
    def __init__(self, aux_weight=0.4):
        super(PSPLoss, self).__init__()
        self.aux_weight = aux_weight
        
    def forward(self, outputs, targets):
        """
        損失関数の計算。

        Parameters
        ----------
        outputs : PSPNetの出力(tuple)
            (output=torch.Size([num_batch, 21, 475, 475]), output_aux=torch.Size([num_batch, 21, 475, 475]))。

        targets : [num_batch, 475, 4755]
            正解のアノテーション情報

        Returns
        -------
        loss : テンソル
            損失の値
        """
        
        loss = F.cross_entropy(outputs[0], targets, reduction='mean')
        loss_aux = F.cross_entropy(outputs[1], targets, reduce='mean')
        
        return loss + self.aux_weight * loss_aux
    

def train_model(net, dataloaders_dict, criterion, scheduler, optimizer, num_epochs):
    
    device = torch.device('cuda:0' if torch.cuda.is_available() else 'cpu')
    
    net.to(device)
    
    torch.backends.cudnn.benchmark = True
    
    # 画像の枚数
    num_train_imgs = len(dataloaders_dict['train'].dataset)
    num_val_imgs = len(dataloaders_dict['val'].dataset)
    batch_size = dataloaders_dict['train'].batch_size
    
    # イテレーションカウンタをセット
    iteration = 1
    logs = []

    # multiple minibatch
    batch_multiplier = 3
    
    for epoch in range(num_epochs):
        
        # 開始時刻を保存
        t_epoch_start = time.time()
        t_iter_start = time.time()
        epoch_train_loss = 0.0  # epochの損失和
        epoch_val_loss = 0.0  # epochの損失和
        
        print('-------------')
        print('Epoch {}/{}'.format(epoch+1, num_epochs))
        print('-------------')
        
        # epochごとの訓練と検証のループ
        for phase in ['train', 'val']:
            if phase == 'train':
                net.train()
                scheduler.step() # 最適化schedulerの更新
                optimizer.zero_grad()
                print('（train）')
                
            else:
                if ((epoch+1) % 5 == 0):  # 検証は5回に1回だけ行う
                    net.eval()
                    print('-------------')
                    print('（val）')
                else:
                    continue
                    
        
            # データローダーからminibatchずつ取り出すループ
            count = 0  # multiple minibatch
            for images, anno_class_images in dataloaders_dict[phase]:
                # ミニバッチがサイズが1だと、バッチノーマライゼーションでエラーになるのでさける
                if images.size(0) == 1:
                    continue
                    
                images = images.to(device)
                anno_class_images = anno_class_images.to(device)
                
                # multiple minibatchでのパラメータの更新
                if (phase == 'train') and (count ==0):
                    optimizer.step()
                    optimizer.zero_grad()
                    count = batch_multiplier
                    
                 # 順伝搬（forward）計算
                with torch.set_grad_enabled(phase=='train'):
                    outputs = net(images)
                    loss = criterion(outputs, anno_class_images.long()) / batch_multiplier
                    
                    # 訓練時はバックプロパゲーション
                    if phase == 'train':  
                        loss.backward()  # 勾配の計算
                        count -= 1  # multiple minibatch
                        
                        if (iteration % 10 == 0):
                            t_iter_finish = time.time()
                            duration = t_iter_finish - t_iter_start
                            print('イテレーション {} || Loss: {:.4f} || 10iter: {:.4f} sec.'.format(
                                iteration, loss.item()/batch_size*batch_multiplier, duration))
                            t_iter_start = time.time()

                        epoch_train_loss += loss.item() * batch_multiplier
                        iteration += 1
                
                    # 検証時
                    else:
                        epoch_val_loss += loss.item() * batch_multiplier
                        
        # epochのphaseごとのlossと正解率
        t_epoch_finish = time.time()
        print('-------------')
        print('epoch {} || Epoch_TRAIN_Loss:{:.4f} ||Epoch_VAL_Loss:{:.4f}'.format(
            epoch+1, epoch_train_loss/num_train_imgs, epoch_val_loss/num_val_imgs))
        print('timer:  {:.4f} sec.'.format(t_epoch_finish - t_epoch_start))
        t_epoch_start = time.time()      
        
        # ログを保存
        log_epoch = {'epoch': epoch+1, 'train_loss': epoch_train_loss /
                     num_train_imgs, 'val_loss': epoch_val_loss/num_val_imgs}
        logs.append(log_epoch)
        df = pd.DataFrame(logs)
        df.to_csv("log_output.csv")
        
    # 最後のネットワークを保存する
    torch.save(net.state_dict(), 'weights/pspnet50_original_' +
               str(epoch+1) + '.pth')


if __name__ == '__main__':
    # ファイルパスのリストを取得
    rootpath = "./data/VOCdevkit/VOC2012/"
    train_img_list, train_anno_list, val_img_list, val_anno_list = make_datapath_list(
        rootpath=rootpath)

    # (RGB)の色の平均値と標準偏差
    color_mean = (0.485, 0.456, 0.406)
    color_std = (0.229, 0.224, 0.225)

    train_dataset = VOCDataset(train_img_list, train_anno_list, phase='train', 
                                                    transform=DataTransform(input_size=475, 
                                                    color_mean=color_mean,
                                                    color_std=color_std))
    val_dataset = VOCDataset(val_img_list, val_anno_list, phase='val',
                                                    transform=DataTransform(input_size=475,
                                                    color_mean=color_mean,
                                                    color_std=color_std))
    
    batch_size = 4

    # Dataloaderの作成
    train_dataloader = data.DataLoader(train_dataset, batch_size=batch_size,
                                                                num_workers=4, shuffle=True)
    val_dataloader = data.DataLoader(val_dataset, batch_size=batch_size,
                                                                num_workers=4, shuffle=False)

    dataloaders_dict = {'train':train_dataloader, 'val':val_dataloader}


    # ファインチューニングでPSPNetを作成
    # ADE20Kデータセットの学習済みモデルを使用、ADE20Kはクラス数が150です
    net = PSPNet(n_classes=150)

    # ADE20K学習済みパラメータをロード
    state_dict = torch.load('weights/pspnet50_ADE20K.pth')
    net.load_state_dict(state_dict)

    # 分類用の畳み込み層を、出力数21のものにつけかえる
    n_classes = 21
    net.decode_feature.classification = nn.Conv2d(
        in_channels=512, out_channels=n_classes, kernel_size=1, stride=1, padding=0)

    net.aux.classification = nn.Conv2d(
        in_channels=256, out_channels=n_classes, kernel_size=1, stride=1, padding=0)

    def weights_init(m):
        if isinstance(m, nn.Conv2d):
            nn.init.xavier_normal_(m.weight.data)
            if m.bias is not None: # バイアス項がある場合
                nn.init.constant_(m.bias, 0.0)

    net.decode_feature.classification.apply(weights_init)
    net.aux.classification.apply(weights_init)

    print('ネットワーク設定完了：学習済みの重みをロードしました')

    criterion = PSPLoss(aux_weight=0.4)

    optimizer = optim.SGD([
    {'params':net.feature_conv.parameters(), 'lr':1e-3},
    {'params':net.feature_res_1.parameters(), 'lr':1e-3},
    {'params':net.feature_res_2.parameters(), 'lr':1e-3},
    {'params':net.feature_dilated_res_1.parameters(), 'lr':1e-3},
    {'params':net.feature_dilated_res_2.parameters(), 'lr':1e-3},
    {'params':net.pyramid_pooling.parameters(), 'lr':1e-3},
    {'params':net.decode_feature.parameters(), 'lr':1e-2},
    {'params':net.aux.parameters(), 'lr':1e-2},
    ], momentum=0.9, weight_decay=0.0001 )

    # スケジューラーの設定
    def lambda_epoch(epoch):
        max_epoch = 30
        return math.pow((1 - epoch/max_epoch), 0.9)

    scheduler = optim.lr_scheduler.LambdaLR(optimizer, lr_lambda=lambda_epoch)

    num_epochs = 1
    
    train_model(net, dataloaders_dict, criterion, scheduler, optimizer, num_epochs=num_epochs)
