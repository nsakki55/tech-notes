import random
import math
import time
import pandas as pd
import numpy as np
from PIL import Image
import matplotlib.pyplot as plt

import torch
import torch.utils.data  as data 
import torch.nn as nn
import torch.nn.functional as F
import torch.optim as optim

from torchvision import transforms

class Generator(nn.Module):
    def __init__(self, z_dim=20):
        super(Generator, self).__init__()
        
        self.layer1 = nn.Sequential(
            nn.Linear(z_dim, 1024),
            nn.BatchNorm1d(1024),
            nn.ReLU(inplace=True))
        
        self.layer2 = nn.Sequential(
            nn.Linear(1024, 7*7*128),
            nn.BatchNorm1d(7*7*128),
            nn.ReLU(inplace=True))
        
        self.layer3 = nn.Sequential(
            nn.ConvTranspose2d(in_channels=128, out_channels=64,
                                                  kernel_size=4, stride=2, padding=1),
            nn.BatchNorm2d(64),
            nn.ReLU(inplace=True))
        
        self.last = nn.Sequential(
            nn.ConvTranspose2d(in_channels=64, out_channels=1,
                                              kernel_size=4, stride=2, padding=1),
            nn.Tanh())
        
    def forward(self, z):
        out = self.layer1(z)
        out = self.layer2(out)
        
        # 転置畳み込み層に入れるためにテンソルの形を整形
        out = out.view(z.shape[0], 128, 7, 7)
        out = self.layer3(out)
        out = self.last(out)
        
        return out

class Discriminator(nn.Module):
    def __init__(self, z_dim=20):
        super(Discriminator, self).__init__()
        
        # 画像側の入力処理。 生成画像G(z)の処理
        self.x_layer1 = nn.Sequential(
            nn.Conv2d(in_channels=1, out_channels=64,
                                 kernel_size=4, stride=2, padding=1),
            nn.LeakyReLU(0.1, inplace=True))
        
        self.x_layer2 = nn.Sequential(
            nn.Conv2d(in_channels=64, out_channels=64, 
                                 kernel_size=4, stride=2, padding=1),
            nn.BatchNorm2d(64),
            nn.LeakyReLU(0.1, inplace=True))
        
        # 乱数側の入力処理。　生成乱数E(x)の処理
        self.z_layer1 = nn.Linear(z_dim, 512)
        
        # 最後の判定 3648 = 64*7*7 + 512
        # x_outとz_outを結合し、全結合層で判定
        self.last1= nn.Sequential(
            nn.Linear(3648, 1024),
            nn.LeakyReLU(0.1, inplace=True))
        
        self.last2 = nn.Linear(1024, 1)
        
    def forward(self, x ,z):
        '''
        x : 生成画像G(z)
        z : 生成乱数E(x)
        '''
        # 画像側の入力処理
        x_out = self.x_layer1(x)
        x_out = self.x_layer2(x_out)
        
        # 乱数側の入力処理
        z = z.view(z.shape[0], -1)
        z_out = self.z_layer1(z)
        
        # x_outとz_outを結合し、全結合層で判定
        x_out = x_out.view(-1, 64*7*7)
        out = torch.cat([x_out, z_out], dim=1)
        out = self.last1(out)
        
        feature = out # 最後にチャネルを1つに集約する手前の情報
        feature = feature.view(feature.size()[0], -1)
        
        out = self.last2(feature)
        
        return out, feature

class Encoder(nn.Module):
    def __init__(self, z_dim=20):
        super(Encoder, self).__init__()
        
        # 注意：白黒画像なので入力チャネルは1つだけ
        self.layer1 = nn.Sequential(
            nn.Conv2d(1, 32, kernel_size=3, stride=1),
            nn.LeakyReLU(0.1, inplace=True))
        
        self.layer2= nn.Sequential(
            nn.Conv2d(32, 64, kernel_size=3, stride=2, padding=1),
            nn.BatchNorm2d(64),
            nn.LeakyReLU(0.1, inplace=True))
        
        self.layer3 = nn.Sequential(
            nn.Conv2d(64, 128, kernel_size=3, stride=2, padding=1),
            nn.LeakyReLU(0.1, inplace=True))
        
        self.last = nn.Linear(128*7*7, z_dim)
        
    def forward(self, x):
        out = self.layer1(x)
        out = self.layer2(out)
        out = self.layer3(out)
        
        out = out.view(-1, 128*7*7)
        out = self.last(out)
        
        return out

class ImageTransform():
    """画像の前処理クラス"""

    def __init__(self, mean, std):
        self.data_transform = transforms.Compose([
            transforms.ToTensor(),
            transforms.Normalize(mean, std)
        ])

    def __call__(self, img):
        return self.data_transform(img)
    
class GAN_Img_Dataset(data.Dataset):
    """画像のDatasetクラス。PyTorchのDatasetクラスを継承"""

    def __init__(self, file_list, transform, return_labels=False):
        self.file_list = file_list
        self.transform = transform
        self.return_labels = return_labels

    def __len__(self):
        '''画像の枚数を返す'''
        return len(self.file_list)

    def __getitem__(self, index):
        '''前処理をした画像のTensor形式のデータを取得'''

        img_path = self.file_list[index]
        img_labels = img_path.split('/')[-1][4]
        img = Image.open(img_path)  # [高さ][幅]白黒

        # 画像の前処理
        img_transformed = self.transform(img)

        if self.return_labels:
            return img_transformed, img_labels

        else:
            return img_transformed




