# Scala 入門

## Note
 
- lazy  
lazy val time = new java.util.Date  
のようにval 宣言の前にlazyをつけると、変数へのアクセス時に初期化を遅らせることができる  

- 変数名はキャメルケース  
関数、クラス名、定数名はMyClass, MyFunctionのように書き、  
メソッド名はprintSomethingのように、小文字始まりで書くのが通例  

- メソッド  
Scalaはクラス、トレイト、オブジェクトに対してメソッドを定義できる  

- 関数  
scalaではメソッドと関数を別は意味をもつ。メソッドはdefキーワードによって定義される  
関数名に空白と_を続けると、関数オブジェクトとして値を返せる。  
関数オブジェクトは、他の関数の引数に渡すことができる
```
// メソッド
def isAlphameric(str: String): Boolean = str.matches("[a-zA-Z0-9\\s]")

// 関数オブジェクト
val isAlphamericF = isAlphameric _ 

// 関数リテラル
val isAlphamericF = (str: String) => str.matches("[a-zA-z0-9\\s]")

val si AlphamericF = new Function1[String, Boolean] {
 def apply(str: String) = str.matches("[a-zA-z0-9\\s]")
 }
```

- if/else  
Scalaっぽくない書き方  
```
val weight = 120
var message: String = null
if (weight < 100){
 message = "OK
 } else {
 message = "over
 }
```
Scalaっぽい書き方(valによる宣言のみ)  
```
val = weight
message = if (weight < 100) {
 "OK"
} else {
"over"
}

val message = if (weight < 100) "OK" else "over"
```
- match
```
val num: Int = mabyNum match {
 case Some(num) => num
 case None(num) => 0
 case 1 | 2 | 3 => 5
 case _ => 0
```

- 型  
Unit: 意味のある値を持たない型＝void  
AnyVal, AnyRef, Any: AnyRefはユーザーが定義した型、Anyは全ての型のスーパークラス  
Null: javaのnull型に相当。実際に使うことはない。  
Nothing: メソッドの途中でreturnしたいときや、プログラムの実行が中断されることを表す.???の型    
自分で型を定義する方法は, クラス・トレイトの定義の２通りの方法が考えられる  

- クラス  
基本はPythonと同様.selfの代わりにthisを用いることで、自身の変数にアクセスできる  
```
// クラスの定義
class Point(x: Int, y: Int) {
// フォールドの宣言
  val x = x
  val y = y
// メソッドの記述
  def distance(that: Point): Int = {
    val xdiff = math.abs(this.x - that.x)
    val ydiff = math.abs(this.y - that.y)
    math.sqrt(xdiff * xdiff + ydiff * ydiff).toInt
  }

  def +(that: Point): Point = {
    new Point(this.x + that.x, this.y + that.y)
  }
}
```


- ケースクラス(case class)について    
case で　classを宣言すると、equal, applyなど、便利なメソッドが追加される  
コンパニオンオブジェクトが定義される。valで宣言されたフィールドとして扱われる  
[参照](https://qiita.com/4245Ryomt/items/ae1468e634523c83d571)  

- オブジェクト(object)について  
シングルトンオブジェクトを示す。インスタンスが自動で生成される。  
唯一のインスタンスで、クラスのように複数のインスタンスを作成することができない。  
object.methodというクラスのようにメソッドにアクセスできる  
[公式ドキュメント](https://docs.scala-lang.org/ja/tour/singleton-objects.html)  
[参照](http://shikashikamemo.hatenablog.com/entry/2014/04/07/220341)   
 
 - Eitherについて  
処理の実行結果が失敗でも成功でも値を保持する  
Left: 失敗, Right: 成功に値を入れる  
[参照](https://qiita.com/peko858/items/91ea6c5f520e71e9ba1d)  

- Optionについて  
値を包み込む(ラップする)クラス  
nullを包み込む。値があればSome型、なければnone型を返す。  
caseによるパターンマッチとの相性いい  
[参照](https://qiita.com/f81@github/items/7bca48469d9aea65780d)  

- Tryについて  
処理のが成功した場合はSuccess型、失敗した場合はFailure型を入れてくれる  
FailureにExceptionを入れるので、例外処理がきれいに書けるようになるらしい  


- 名前渡しパラメーター  
関数に渡した値を、関数ないで呼び出したタイミングで評価を行う方法  
渡した値が計算コストが高い場合などに有効  
[公式ドキュメント](https://docs.scala-lang.org/ja/tour/by-name-parameters.html)  

- Implicitについて  
implicit conversionは暗黙の型変換機能をユーザが定義できるようにする機能  
pimp my libraryパターン: 既存のクラスにメソッドを追加して拡張する（ようにみせかける）使い方  
[参照](https://qiita.com/miyatin0212/items/f70cf68e89e4367fcf2e)  
[公式ドキュメント](https://docs.scala-lang.org/ja/tour/implicit-parameters.html)

- implicity について  
親クラスの暗黙の変数を取り出すことができる  
[参照](https://qiita.com/someone7140/items/4ceb041f0a4518ae5300)  

- Futureについて  
非同期に処理される結果が入ったOption型のようなもの  
