import torch.nn as nn
import torch
class Self_Attention(nn.Module):
    """ Self-AttentionのLayer"""
    def __init__(self, in_dim):
            super(Self_Attention, self).__init__()
            
            # 1×1の畳み込み層によるpointwise convolutionを用意
            # query : 入力xの転置
            self.query_conv = nn.Conv2d(
                in_channels=in_dim, out_channels=in_dim//8, kernel_size=1)
            # key : 入力x
            self.key_conv = nn.Conv2d(
                in_channels=in_dim, out_channels=in_dim//8, kernel_size=1)
            # value : Attention Map beta と掛け算する対象
            self.value_conv = nn.Conv2d(
                in_channels=in_dim, out_channels=in_dim, kernel_size=1)
            
            # Attention Map作成時の規格化のソフトマックス
            self.softmax = nn.Softmax(dim=-2)
            
            # 元の入力xとSelf-Attention Mapであるoを足し算するときの係数
            # output = x +gamma*o
            # 最初はgamma=0で、学習させていく
            self.gamma = nn.Parameter(torch.zeros(1))
            
    def forward(self, x):
        
        # 入力変数
        X = x

        # 畳み込みをしてから、サイズを変形する。 B,C',W,H→B,C',N へ
        proj_query = self.query_conv(X).view(
            X.shape[0], -1, X.shape[2]*X.shape[3]) # サイズ：B,C',N
        
        proj_query = proj_query.permute(0, 2, 1) # 転置操作
        proj_key = self.key_conv(X).view(
            X.shape[0], -1, X.shape[2]*X.shape[3]) # サイズ：B,C',N
        
        # かけ算
        # https://pytorch.org/docs/stable/torch.html#torch.bmm
        S = torch.bmm(proj_query, proj_key)  #バッチごとの行列かけ算
        
        attention_map_T = self.softmax(S) # 行i方向の和を1にするソフトマックス関数
        attention_map = attention_map_T.permute(0, 2, 1)  # 転置をとる
        
        # Self-Attention Mapを計算する
        proj_value = self.value_conv(X).view(
            X.shape[0], -1, X.shape[2]*X.shape[3])
        o = torch.bmm(proj_value, attention_map.permute(0, 2, 1)) # Attention Mapは転置してかけ算
        
        # Self-Attention MapであるoのテンソルサイズをXにそろえて、出力にする
        o = o.view(X.shape[0], X.shape[1], X.shape[2], X.shape[3])
        out = x + self.gamma*o
        
        return out, attention_map