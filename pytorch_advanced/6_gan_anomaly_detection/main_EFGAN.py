# パッケージのimport
import random, math, time, argparse, os, datetime
import pandas as pd
import numpy as np
from PIL import Image
import cv2
import matplotlib.pyplot as plt
from logging import getLogger, DEBUG, INFO, StreamHandler, basicConfig, FileHandler, Formatter

import torch
import torch.utils.data as data
import torch.nn as nn
import torch.nn.functional as F
import torch.optim as optim

from torchvision import transforms
from EfficientGAN import Generator, Discriminator, Encoder, GAN_Img_Dataset, ImageTransform


# Setup seeds
torch.manual_seed(1234)
torch.cuda.manual_seed(1234)
np.random.seed(1234)
random.seed(1234)

def train_model(G, D, E, dataloader, args):
    
    # GPUが使えるかを確認
    device = torch.device("cuda:0" if torch.cuda.is_available() else "cpu")
    logger.info("使用デバイス：{}".format(device))
    
    # 最適化手法の設定
    lr_ge = 0.0001
    lr_d = 0.0001/4
    beta1, beta2 = 0.5, 0.999
    g_optimizer = torch.optim.Adam(G.parameters(), lr_ge, [beta1, beta2])
    e_optimizer = torch.optim.Adam(E.parameters(), lr_ge, [beta1, beta2])
    d_optimizer = torch.optim.Adam(D.parameters(), lr_d, [beta1, beta2])

    # 誤差関数を定義
    # BCEWithLogitsLossは入力にシグモイド（logit）をかけてから、
    # バイナリークロスエントロピーを計算
    criterion = nn.BCEWithLogitsLoss(reduction='mean')
    
    # パラメータをハードコーディング
    z_dim = args.z_dim
    mini_batch_size = args.train_batch_size
    
    # ネットワークをGPUへ
    G.to(device)
    E.to(device)
    D.to(device)

    G.train()  # モデルを訓練モードに
    E.train()  # モデルを訓練モードに
    D.train()  # モデルを訓練モードに

    # ネットワークがある程度固定であれば、高速化させる
    torch.backends.cudnn.benchmark = True

    # 画像の枚数
    num_train_imgs = len(dataloader.dataset)
    batch_size = dataloader.batch_size
    

    # イテレーションカウンタをセット
    iteration = 1
    logs = []

    # epochのループ
    for epoch in range(args.num_epochs):

        # 開始時刻を保存
        t_epoch_start = time.time()
        epoch_g_loss = 0.0  # epochの損失和
        epoch_e_loss = 0.0  # epochの損失和
        epoch_d_loss = 0.0  # epochの損失和

        logger.info('-------------')
        logger.info('Epoch {}/{}'.format(epoch, args.num_epochs))
        logger.info('-------------')
        logger.info('（train）')
        
        # データローダーからminibatchずつ取り出すループ
        for imges in dataloader:

            # ミニバッチがサイズが1だと、バッチノーマライゼーションでエラーになるのでさける
            if imges.size()[0] == 1:
                continue
                
            # ミニバッチサイズの1もしくは0のラベル役のテンソルを作成
            # 正解ラベルと偽ラベルを作成
            # epochの最後のイテレーションはミニバッチの数が少なくなる
            mini_batch_size = imges.size()[0]
            label_real = torch.full((mini_batch_size,), 1).to(device)
            label_fake = torch.full((mini_batch_size,), 0).to(device)

            # GPUが使えるならGPUにデータを送る
            imges = imges.to(device)
            
            # --------------------
            # 1. Discriminatorの学習
            # --------------------
            
            # 真の画像を判定　
            z_out_real = E(imges)
            d_out_real, _ = D(imges, z_out_real)
            
            # 偽の画像を生成して判定
            input_z = torch.randn(mini_batch_size, z_dim).to(device)
            fake_images = G(input_z)
            d_out_fake, _ = D(fake_images, input_z)
            
            # 誤差を計算
            d_loss_real = criterion(d_out_real.view(-1), label_real)
            d_loss_fake = criterion(d_out_fake.view(-1), label_fake)
            d_loss = d_loss_real + d_loss_fake
            
            # バックプロパゲーション
            d_optimizer.zero_grad()
            d_loss.backward()
            d_optimizer.step()
            
            # --------------------
            # 2. Generatorの学習
            # --------------------
            # 偽の画像を生成して判定
            
            # 偽の画像を生成して判定
            input_z = torch.randn(mini_batch_size, z_dim).to(device)
            fake_images = G(input_z)
            d_out_fake, _ = D(fake_images, input_z)
            
            # 誤差を計算
            g_loss = criterion(d_out_fake.view(-1), label_real)
            
            # バックプロパゲーション
            g_optimizer.zero_grad()
            g_loss.backward()
            g_optimizer.step()
            
            # --------------------
            # 3. Encoderの学習
            # --------------------
            
            # 真の画像のzを推定
            z_out_real = E(imges)
            d_out_real, _ =D(imges, z_out_real)
            
            # 誤差を計算
            e_loss = criterion(d_out_real.view(-1), label_fake)
            
            # バックプロパゲーション
            e_optimizer.zero_grad()
            e_loss.backward()
            e_optimizer.step()
            
            # --------------------
            # 4. 記録
            # --------------------
            epoch_d_loss += d_loss.item()
            epoch_g_loss += g_loss.item()
            epoch_e_loss += e_loss.item()
            iteration += 1
            
        # 10epochごとに生成結果を保存
        if (epoch + 1) % 10 == 0:
        # 出力
                
            fig = plt.figure(figsize=(15, 3))
            for i in range(0, 5):

                # 下段に生成データを表示する
                plt.subplot(1, 5, i+1)
                plt.imshow(fake_images[i][0].cpu().detach().numpy(), 'gray')
            
            img_path = os.path.join(args.save_path,'{}th_epoch_generated_figure.png'.format(epoch+1))
            plt.savefig(img_path)

        # epochのphaseごとのlossと正解率
        t_epoch_finish = time.time()
        logger.info('-------------')
        logger.info('epoch {} || Epoch_D_Loss:{:.4f} ||Epoch_G_Loss:{:.4f} ||Epoch_E_Loss:{:.4f}'.format(
            epoch, epoch_d_loss/batch_size, epoch_g_loss/batch_size, epoch_e_loss/batch_size))
        logger.info('timer:  {:.4f} sec.'.format(t_epoch_finish - t_epoch_start))
        t_epoch_start = time.time()
        
        
        log_epoch = {'epoch' : epoch+1,
                    'd_loss' : epoch_d_loss/batch_size,
                    'g_loss' : epoch_g_loss/batch_size,
                    'e_loss' : epoch_e_loss/batch_size}

        logs.append(log_epoch)
        df = pd.DataFrame(logs)
        df_path = os.path.join(args.save_path, 'EFGAN_train_loss.csv')
        df.to_csv(df_path)  

        torch.save(G.state_dict(), os.path.join(args.save_path, 'generator'))
        torch.save(D.state_dict(), os.path.join(args.save_path, 'discriminator'))
        torch.save(E.state_dict(), os.path.join(args.save_path, 'encoder'))

    logger.info("総イテレーション回数:{}".format(iteration))
    logger.info('train model END')

    return G, D, E

# ネットワークの初期化
def weights_init(m):
    classname = m.__class__.__name__
    if classname.find('Conv') != -1:
        # conv2dとConvTranspose2dの初期化
        nn.init.normal_(m.weight.data, 0.0, 0.02)
        nn.init.constant_(m.bias.data, 0)
    elif classname.find('BatchNorm') != -1:
        # BatchNorm2dの初期化
        nn.init.normal_(m.weight.data, 0.0, 0.02)
        nn.init.constant_(m.bias.data, 0)
    elif classname.find('Linear') != -1:
        # 全結合層Linearの初期化
        m.bias.data.fill_(0)
        
def make_datapath_list(img_num=6000):
    """学習、検証の画像データとアノテーションデータへのファイルパスリストを作成する。 """

    train_img_list = list()  # 画像ファイルパスを格納

    for img_idx in range(img_num):
        img_path = "./data_all/img_5_28size/img_5_" + str(img_idx)+'.jpg'
        train_img_list.append(img_path)

    return train_img_list


def make_test_datapath_list(img_num=6000):
    """学習、検証の画像データとアノテーションデータへのファイルパスリストを作成する。 """

    test_img_list = list()  # 画像ファイルパスを格納

    for img_idx in range(img_num):
        img_path = "./data_all/test_28size/img_5_" + str(img_idx)+'.jpg'
        test_img_list.append(img_path)

        img_path = "./data_all/test_28size/img_4_" + str(img_idx)+'.jpg'
        test_img_list.append(img_path)

    return test_img_list

def Anomaly_score(x, fake_img, z_out_real, D, Lambda=0.1):

    # テスト画像xと生成画像fake_imgのピクセルレベルの差の絶対値を求めて、ミニバッチごとに和を求める
    residual_loss = torch.abs(x-fake_img)
    residual_loss = residual_loss.view(residual_loss.size()[0], -1)
    residual_loss = torch.sum(residual_loss, dim=1)

    # テスト画像xと生成画像fake_imgを識別器Dに入力し、特徴量マップを取り出す

    _, x_feature = D(x, z_out_real)
    _, G_feature = D(fake_img, z_out_real)

    # テスト画像xと生成画像fake_imgの特徴量の差の絶対値を求めて、ミニバッチごとに和を求める
    discrimination_loss = torch.abs(x_feature-G_feature)
    discrimination_loss = discrimination_loss.view(
        discrimination_loss.size()[0], -1)
    discrimination_loss = torch.sum(discrimination_loss, dim=1)

    # ミニバッチごとに2種類の損失を足し算する
    loss_each = (1-Lambda)*residual_loss + Lambda*discrimination_loss

    # ミニバッチ全部の損失を求める
    total_loss = torch.sum(loss_each)

    return total_loss, loss_each, residual_loss


def EFGAN(G_update, D_update, E_update, test_dataloader, args):

    logger.info('EfficientGAN annomaly detection START')
    EFGAN_start = datetime.datetime.now()
    
    batch_size = test_dataloader.batch_size
    logger.info('batch size:{}'.format(batch_size))
    device = torch.device("cuda:0" if torch.cuda.is_available() else "cpu")

    true_loss_logs = []
    annomaly_loss_logs = []
    for i, (images, labels) in enumerate(test_dataloader):
        logger.info('{} / {} batch START'.format(i+1,args.num_test_images//batch_size))

        batch_start = datetime.datetime.now()

        # 異常検知したい画像
        x = images[:batch_size]
        x = x.to(device)

        # 教師データの画像をエンコードしてzにしてから、Gで生成
        z_out_real = E_update(images.to(device))
        images_reconstract = G_update(z_out_real)

        # 損失を求める
        loss, loss_epoch, residual_loss_epoch = Anomaly_score(x, images_reconstract, z_out_real, D_update, Lambda=0.1)

        # 損失の計算。トータルの損失
        loss_epoch = loss_epoch.cpu().detach().numpy()

        true_index = [i for i, x in enumerate(labels) if x == '5']
        annomaly_index = [i for i, x in enumerate(labels) if x == '4']

        true_loss = loss_epoch[true_index]
        annomaly_loss = loss_epoch[annomaly_index] 

        true_loss_logs.extend(true_loss)
        annomaly_loss_logs.extend(annomaly_loss)

        batch_end = datetime.datetime.now()

        logger.info('{} / {} batch Finish, timer: {}'.format(i+1,args.2*num_test_images//batch_size +1, 
                                                                batch_end-batch_start))

        np.save(os.path.join(args.save_path, 'true_loss'), true_loss_logs)
        np.save(os.path.join(args.save_path, 'annomaly_loss'), annomaly_loss_logs)

    EFGAN_end = datetime.datetime.now()

    logger.info('EfficientGAN annomaly detection END timer: {}'.format(EFGAN_end - EFGAN_start))



if __name__ == '__main__':
    parser = argparse.ArgumentParser(description='EfficientGAN for mnist')

    parser.add_argument('save_path', default=str)
    parser.add_argument('--num_epochs', default=200, type=int)
    parser.add_argument('--num_train_images', default=6000, type=int)
    parser.add_argument('--num_test_images', default=300, type=int)
    parser.add_argument('--z_dim', default=20,type=int)
    parser.add_argument('--train_batch_size', default=64, type=int)
    parser.add_argument('--test_batch_size', default=10, type=int)
    parser.add_argument('--train', action='store_true')
    parser.add_argument('--generator_path', type=str)
    parser.add_argument('--discriminator_path', type=str)
    parser.add_argument('--encoder_path', type=str)

    args = parser.parse_args()

    logger = getLogger(__name__)
    logger.setLevel(DEBUG)

    formatter = '%(levelname)s : %(asctime)s : %(name)s : %(message)s'
    format = Formatter(formatter)

    log_file = os.path.basename(__file__) + '.log'
    log_path = os.path.join(args.save_path, log_file)
    fh = FileHandler(log_path)
    fh.setFormatter(format)
    logger.addHandler(fh)

    sh = StreamHandler()
    sh.setLevel(DEBUG)
    sh.setFormatter(format)
    logger.addHandler(sh)

    if args.train:
        G = Generator(z_dim=args.z_dim)
        D = Discriminator(z_dim=args.z_dim)
        E = Encoder(z_dim=args.z_dim)

        # 初期化の実施
        G.apply(weights_init)
        E.apply(weights_init)
        D.apply(weights_init)

        # ファイルリストを作成
        train_img_list=make_datapath_list(img_num=args.num_train_images)

        # Datasetを作成
        mean = (0.5,)
        std = (0.5,)
        train_dataset = GAN_Img_Dataset(
            file_list=train_img_list, transform=ImageTransform(mean, std), return_labels=False)

        train_dataloader = torch.utils.data.DataLoader(
            train_dataset, batch_size=args.train_batch_size, shuffle=True)


        G_update, D_update, E_update = train_model(G, D, E, train_dataloader, args)

    else:
        G_update = Generator(z_dim=args.z_dim)
        D_update = Discriminator(z_dim=args.z_dim)
        E_update = Encoder(z_dim=args.z_dim)

        device = torch.device("cuda:0" if torch.cuda.is_available() else "cpu")

        G_update.load_state_dict(torch.load(args.generator_path))
        G_update.to(device)

        D_update.load_state_dict(torch.load(args.discriminator_path))
        D_update.to(device)

        E_update.load_state_dict(torch.load(args.encoder_path))
        E_update.to(device)

    # ファイルリストを作成
    test_img_list = make_test_datapath_list(img_num=args.num_test_images)
    #
    #  Datasetを作成
    mean = (0.5,)
    std = (0.5,)
    test_dataset = GAN_Img_Dataset(
        file_list=test_img_list, transform=ImageTransform(mean, std), return_labels=True)

    test_dataloader = torch.utils.data.DataLoader(
        test_dataset, batch_size=args.test_batch_size, shuffle=False)

    
    EFGAN(G_update, D_update, E_update, test_dataloader, args)