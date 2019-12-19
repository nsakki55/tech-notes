# Castella book
章ごとの内容をざっくりまとめる。
## 3章
3章解説スライド  
解説っていうよりまとめに近い  
https://www.slideshare.net/shoichipincotaguchi/3-75873101  
Ridge, Lassoの詳しい内容。変数選択に関わる部分。  

## 4章
４章前半まつけんさん解説スライド   
https://www.slideshare.net/matsukenbook/4-63878216  
４章後半、まとめスライド  
https://speakerdeck.com/ysekky/castella-book-chap4?slide=21  
線形分離、ロジスティック回帰の内容。  

## 5章
５章まとめスライド  
https://www.slideshare.net/TakayukiUchiba1/5-76583678    
こっちのスライドの方が詳しい。  
https://www.slideshare.net/KotaMori/556-65129868?qid=ba92724c-fa24-4177-adbd-0ae66b65195e&v=&b=&from_search=2  
スプラインのお話。平滑化がキーワドな章 

## 6章
カーネル平滑化の内容。  
局所領域で推定が柔軟にできるように着目する点に近い観測点だけをつかって回帰関数が滑らかになるようにモデルを作る方法。  
局所限定は観測点から着目する点からの距離に基づく重みを付与する重み関数＝カーネルKを介して実現できるらしい。  
局所回帰に特価したカーネルのことであり、SVMで用いられる高次元特徴空間での内積を計算するカーネルとは異なる。 
### 6-1
KNNの回帰曲線は、着目点に近い点の平均が回帰曲線になるものだった。近傍の全ての点に等しい重みをKNNでは付与するため、回帰曲線が波打つ不連続なものになる。　　
着目点からの距離に応じて重みが減少するといい感じに滑らかになる。  
