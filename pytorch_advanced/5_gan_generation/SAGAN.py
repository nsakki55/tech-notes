# パッケージのimport
import random
import math
import time
import glob
import pandas as pd
import numpy as np
from PIL import Image
import matplotlib.pyplot as plt
import warnings
warnings.filterwarnings('ignore')

import torch
import torch.utils.data as data
import torch.nn as nn
import torch.nn.functional as F
import torch.optim as optim

from torchvision import transforms

from sagan_generator import Generator
from sagan_discriminator import Discriminator
from dataloader import ImageTransform, GAN_Img_Dataset

# Setup seeds
torch.manual_seed(1234)
np.random.seed(1234)
random.seed(1234)

# ネットワークの初期化
def weights_init(m):
    classname = m.__class__.__name__
    if classname.find('Conv') != -1:
        # Conv2dとConvTranspose2dの初期化
        nn.init.normal_(m.weight.data, 0.0, 0.02)
        nn.init.constant_(m.bias.data, 0)
    elif classname.find('BatchNorm') != -1:
        # BatchNorm2dの初期化
        nn.init.normal_(m.weight.data, 1.0, 0.02)
        nn.init.constant_(m.bias.data, 0)

def plot_lr(df):
    plt.rcParams['font.size'] = 14
    fig = plt.figure(figsize=(16, 6))
    ax = fig.add_subplot(121)
    ax.plot(df['epoch'], df['g_loss'], '.-', c='b',label='G')
    ax.set_xlabel('epoch', fontsize=14)
    ax.set_ylabel('G loss', fontsize=14)
    ax.set_title('G loss')

    ax = fig.add_subplot(122)
    ax.plot(df['epoch'], df['d_loss'], '.-', c='orange',label='D')
    ax.set_xlabel('epoch', fontsize=14)
    ax.set_ylabel('D loss', fontsize=14)
    ax.set_title('D loss')

    fig.savefig('SAGAN/learnig_curbe.png')

def main():

    G = Generator(z_dim=100, image_size=64)
    D = Discriminator(z_dim=100, image_size=64)

    # 初期化の実施
    G.apply(weights_init)
    D.apply(weights_init)

    print("ネットワークの初期化完了")

    # ファイルリストを作成
    train_img_list = glob.glob('anime/*png')

    # Datasetを作成
    mean = (0.5,0.5, 0.5)
    std = (0.5, 0.5, 0.5)
    train_dataset = GAN_Img_Dataset(
        file_list=train_img_list, transform=ImageTransform(mean, std))

    # DataLoaderを作成
    batch_size = 64

    dataloader = torch.utils.data.DataLoader(
        train_dataset, batch_size=batch_size, shuffle=True)

    # GPUが使えるかを確認
    device = torch.device("cuda:0" if torch.cuda.is_available() else "cpu")
    print("使用デバイス：", device)

    # 最適化手法の設定
    g_lr, d_lr = 0.0001, 0.0004
    beta1, beta2 = 0.0, 0.9
    g_optimizer = torch.optim.Adam(G.parameters(), g_lr, [beta1, beta2])
    d_optimizer = torch.optim.Adam(D.parameters(), d_lr, [beta1, beta2])

    # パラメータをハードコーディング
    z_dim = 100
    mini_batch_size = 64

    # ネットワークをGPUへ
    G.to(device)
    D.to(device)

    G.train()  # モデルを訓練モードに
    D.train()  # モデルを訓練モードに

    # ネットワークがある程度固定であれば、高速化させる
    torch.backends.cudnn.benchmark = True

    # 画像の枚数
    num_train_imgs = len(dataloader.dataset)
    batch_size = dataloader.batch_size

    # イテレーションカウンタをセット
    iteration = 1
    logs = []

    num_epochs = 200

    # epochのループ
    for epoch in range(num_epochs):

        # 開始時刻を保存
        t_epoch_start = time.time()
        epoch_g_loss = 0.0  # epochの損失和
        epoch_d_loss = 0.0  # epochの損失和

        print('-------------')
        print('Epoch {}/{}'.format(epoch, num_epochs))
        print('-------------')
        print('（train）')

        # データローダーからminibatchずつ取り出すループ
        for imges in dataloader:

            # --------------------
            # 1. Discriminatorの学習
            # --------------------
            # ミニバッチがサイズが1だと、バッチノーマライゼーションでエラーになるのでさける
            if imges.size()[0] == 1:
                continue

            # GPUが使えるならGPUにデータを送る
            imges = imges.to(device)

            # 正解ラベルと偽ラベルを作成
            # epochの最後のイテレーションはミニバッチの数が少なくなる
            mini_batch_size = imges.size()[0]

            # 真の画像を判定
            d_out_real, _, _ = D(imges)

            # 偽の画像を生成して判定
            input_z = torch.randn(mini_batch_size, z_dim).to(device)
            input_z = input_z.view(input_z.size(0), input_z.size(1), 1, 1)
            fake_images, _, _ = G(input_z)
            d_out_fake, _, _ = D(fake_images)


            # 誤差を計算→hinge version of the adversarial lossに変更
            d_loss_real = torch.nn.ReLU()(1.0 - d_out_real).mean()
            # 誤差　d_out_realが1以上で誤差0になる。d_out_real>1で、
            # 1.0 - d_out_realが負の場合ReLUで0にする

            d_loss_fake = torch.nn.ReLU()(1.0 + d_out_fake).mean()
            # 誤差　d_out_fakeが-1以下なら誤差0になる。d_out_fake<-1で、
            # 1.0 + d_out_realが負の場合ReLUで0にする

            d_loss = d_loss_real + d_loss_fake

            # バックプロパゲーション
            g_optimizer.zero_grad()
            d_optimizer.zero_grad()

            d_loss.backward()
            d_optimizer.step()

            # --------------------
            # 2. Generatorの学習
            # --------------------
            # 偽の画像を生成して判定
            input_z = torch.randn(mini_batch_size, z_dim).to(device)
            input_z = input_z.view(input_z.size(0), input_z.size(1), 1, 1)
            fake_images, _, _ = G(input_z)
            d_out_fake, _, _ = D(fake_images)

            # 誤差を計算
            g_loss = - d_out_fake.mean()

            # バックプロパゲーション
            g_optimizer.zero_grad()
            d_optimizer.zero_grad()
            g_loss.backward()
            g_optimizer.step()

            # --------------------
            # 3. 記録
            # --------------------
            epoch_d_loss += d_loss.item()
            epoch_g_loss += g_loss.item()
            iteration += 1

        # 10epochごとに生成結果を保存
        if (epoch + 1) % 10 == 0:
                # 出力
                
            fig = plt.figure(figsize=(15, 3))
            for i in range(0, 5):

                # 下段に生成データを表示する
                plt.subplot(1, 5, i+1)
                plt.imshow(fake_images[i].cpu().detach().numpy().transpose(1, 2, 0))
            
            plt.savefig('SAGAN/{}th_epoch_generated_figure.png'.format(epoch+1))

        # epochのphaseごとのlossと正解率
        t_epoch_finish = time.time()
        print('-------------')
        print('epoch {} || Epoch_D_Loss:{:.4f} ||Epoch_G_Loss:{:.4f}'.format(
            epoch, epoch_d_loss/batch_size, epoch_g_loss/batch_size))
        print('timer:  {:.4f} sec.'.format(t_epoch_finish - t_epoch_start))
        t_epoch_start = time.time()

        log_epoch = {'epoch' : epoch+1,
                     'g_loss' : epoch_g_loss/batch_size,
                     'd_loss' : epoch_d_loss/batch_size}
        logs.append(log_epoch)
        df = pd.DataFrame(logs) 
        df.to_csv('SAGAN/log_output.csv')  
        plot_lr(df) 

    g_save_path = 'SAGAN/weight_generator.pth'
    d_save_path = 'SAGAN/weight_discriminator.pth'

    torch.save(G.state_dict(), g_save_path)
    torch.save(D.state_dict(), d_save_path)


    fixed_z = torch.randn(batch_size, z_dim)
    fixed_z = fixed_z.view(fixed_z.size(0), fixed_z.size(1), 1, 1)

    # 画像生成
    fake_images = G(fixed_z.to(device))

    # 訓練データ
    batch_iterator = iter(dataloader)  # イテレータに変換
    images = next(batch_iterator)  # 1番目の要素を取り出す

    # 出力
    fig = plt.figure(figsize=(15, 6))
    for i in range(0, 5):
        
        # 上段に訓練データを
        plt.subplot(2, 5, i+1)
        plt.imshow(images[i].cpu().detach().numpy().transpose(1, 2, 0))

        # 下段に生成データを表示する
        plt.subplot(2, 5, 5+i+1)
        plt.imshow(fake_images[i].cpu().detach().numpy().transpose(1, 2, 0))
        
    plt.savefig('SAGAN/generated_figure.png')

if __name__ == '__main__':
    main()