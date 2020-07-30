# Scala 入門
学んだ基本事項をまとめる  
[ドワンゴscala研修資料](https://scala-text.github.io/scala_text/)  
 
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

- if/else  ~~~~
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

- for文  
flatMap, map, withFilter, foreachのメソッドを併用する場面が多い  
for (ジェネレーター1; ジェネレーター2; ジェネレーター3 if 条件式){式}  
という形式を用いる。  
yieldを用いると、コレクションの要素を加工して返すことができる  
```
for (i <- List(1, 2, 3)) yield {
    i + 1
}

// collectionとの相性がいい
for {i1 <- Option(1)
     i2 <- Option(2)
     i3 <- Option(3)
} yield i1 + i2 + i3

// for 文を書かないと、ネストしてしまう
val o1: Option[Int] = Some(1)
val o2: Option[Int] = Some(2)
val o3: Option[Int] = Some(3)
o1.flatMap { i1 => 
    o2.flatMap { i2 => 
        o3.flatMap {i3 => 
            i1 + i2 + i3
        }
    }
}

// yieldでは、ジェネレータの右辺の方が揃っている必要がある
// 以下はエラーを吐かれる
for (i <- Option(1); l <- Seq(1, 2)) yield i + l

// foreachをforで置き換える際には、yieldはひつようなくなる
for (i <- Option(1); l <- Seq(1, 2)) println( i + l )
```

- throw  
javaのthrowとほぼ同じ動きをする  
Throwable を継承した例外クラスのインスタンスならなんでも投げられる  
```
throw new RuntimeException("error")
```

- match
```
val num: Int = mabyNum match {
 case Some(num) => num
 case None(num) => 0
 case 1 | 2 | 3 => 5
 case _ => 0
```

- 修飾子  
クラス、トレイトを定義する際につけることができる機能  
・private:  定義したクラス、トレイト内のみアクセス可能にする  
・protected: 継承先のクラスやトレイト内からもアクセス可能にする  
・lazy: 計算の一部を遅らせる  
・final: オーバーライドを防ぐ  
・abstract: 継承先のクラスでの実装を要求する[公式ドキュメント](https://docs.scala-lang.org/ja/tour/abstract-type-members.html)    

- ジェネリクスと型パラメータ  
コンテナの要素型を抽象化し、プログラムを柔軟に構築するための機能      
```
class クラス名[型パラメータ1, 型パラメータ2...](クラスパラメータ){
    フィールド・メソッド定義

class Cell[A](var value: A) {
    def put(newValue: A): Unit = 
        value = newValue
    
    def get: A = value 
}

val cell = new Cell[String]("Hello")
```

- パッケージ  
Scalaの名前空間を表現する機能  
クラス、オブジェクト、トレイトしか所属できない制限がある  
ファイル冒頭で以下のように宣言する  
```
package com.github.taisukeoe
```
パッケージオブジェクト:   
パッケージに直接メソッドを書き込む場合の方法.    
```
package object mypackage {
    def hello(): Unit = {
        println("hello")
    }
}

// import の方法
import com.github.taisukeoe.mypackage.hello
import com.github.taisukeoe.mypackage.{hello => ScalaHello}
import com.github.taisukeoe.mypackage._

```
- 無名クラス  
あるクラスを継承したインスタンスをその場で作ることができる方法  
```
~~// Threadクラスを継承
new Thread {
    override def run(): Unit = {
        for(i <- 1 to 10) println(i)
    }
}.start()~~
```

- 型  
Unit: 意味のある値を持たない型＝void  
AnyVal, AnyRef, Any: AnyRefはユーザーが定義した型、Anyは全ての型のスーパークラス  
Null: javaのnull型に相当。実際に使うことはない。  
Nothing: メソッドの途中でreturnしたいときや、プログラムの実行が中断されることを表す.???の型    
自分で型を定義する方法は, クラス・トレイトの定義の２通りの方法が考えられる  

- クラス  
基本はPythonと同様.selfの代わりにthisを用いることで、自身の変数にアクセスできる  
extends で継承を行える  
abstract をクラス前につけることで、直接newされることを防げる  
scalaのクラスは一つの親クラスのみしか継承できないが、複数のトレイトをミックスインできる  
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

- トレイト  
classのnewでインスタンス化できる機能を除いた  
```
trait Namable {
    val name: String
    def display(): Unit = println(name)

// classへのmixinの方法
class Employee(val name: String) extends AnyRef with Namable 
val taro = new Employee("taro")
taro.display()
```

- ケースクラス(case class)    
case で　classを宣言すると、equal, applyなど、便利なメソッドが追加される  
classをそのまま定義すると、  
Mapのキーになれない(hashCodeとequalsメソッドがオーバーライドされていないため)  
toStringメソッドを呼び出した時の結果が見辛い  
明示的にnewでインスタンスを生成する必要がある。  
もし、上記の機能をclassnにつけるには、以下のように各必要がある。  
```
class Point2(val x: Int, val y: Int) {
     override def hashCode(): Int = x + y
     override def equals(that: Any): Boolean = that match {
       case that: Point => x == that.x && y == that.y
       case _ => false
     }
     override def toString(): String = "Point(" + x + "," + y +")"
   }
   
   object Point2 {
     def apply(x: Int, y: Int): Point2 = new Point2(x, y)
   }

```
caseを使えば、同じ処理を一文で書くことができる  
```
case class Point(x: Int, y: Int)
```

コンパニオンオブジェクトが定義される。valで宣言されたフィールドとして扱われる  
[参照](https://qiita.com/4245Ryomt/items/ae1468e634523c83d571)  


- ブロック式  
複数の式をまとめるには  
{式1;式2;式3;式4;式5;}  
のように記述する  



- オブジェクト(object)について  
シングルトンオブジェクトを示す。インスタンスが自動で生成される。  
唯一のインスタンスで、クラスのように複数のインスタンスを作成することができない。  
object.methodというクラスのようにメソッドにアクセスできる  
[公式ドキュメント](https://docs.scala-lang.org/ja/tour/singleton-objects.html)  
[参照](http://shikashikamemo.hatenablog.com/entry/2014/04/07/220341)   
 
 - Eitherについて  
処理の実行結果が失敗でも成功でも値を保持する  
Left: 失敗, Right: 成功に値を入れる  
```
val r: Either[String, Int] = Right(100)
// Rightのときに実行される
r.foreach(println)
// Leftのときに実行される
r.left.foreach(println)
// Eitherの変換
r.map(_ * 2)
r.right.map(_ * 2)
r.left.map(_ * 2)
r.flatMap(l => Right(l * 100))
// Eitherの取り出し
Right(1).getOrElse(100)
```
[参照](https://qiita.com/peko858/items/91ea6c5f520e71e9ba1d)  

- Optionについて  
値を包み込む(ラップする)クラス  
nullを包み込む。値があればSome型、なければNone型を返す。  
中の値を確認する際はOption.foreach(println)を用いるのが安全  
foreachの引数はA => Unit をとる。A はOptionの型パラメータ  
Optionの変換はmapを用いる.関数がA => Option(B)の場合はflatMapを用いる  
値の取り出しはgetOrElseメソッドを使う
```
Option(123L).map(_.toString)
None.map(_.toString) // 何もされない　 
def plus(opt1: Option[Int], opt2: Option[Int]): Option[Int] = {
    opt1.flatMap(i => opt2.map(j => i + j))
   // for 文を使うとすっきりする
    for (i <- opt1; j <- opt2) yield i + j
}

Option(123).getOrElse(0)
```

caseによるパターンマッチとの相性いい  
[参照](https://qiita.com/f81@github/items/7bca48469d9aea65780d)  

- Try  
処理のが成功した場合はSuccess型、失敗した場合はFailure型を入れてくれる  
FailureにExceptionを入れるので、例外処理がきれいに書けるようになるらしい  
```
def div(a: Int, b: Int): Try[Int] = Try(a / b)
// Tryの値確認
div(10, 3).foreach(println)
div(10, 0).failed.foreach(println)
div(10, 3).map(_ * 4)
div(10, 3).flatMap(i => i + 4)

div(10, 3).getOrElse(-1)
```

- 名前渡しパラメーター  
関数に渡した値を、関数ないで呼び出したタイミングで評価を行う方法  
渡した値が計算コストが高い場合などに有効  
[公式ドキュメント](https://docs.scala-lang.org/ja/tour/by-name-parameters.html)  

- Implicitについて  
implicit conversionは暗黙の型変換機能をユーザが定義できるようにする機能  
```
implicit def intToBoolean(n: Int): Boolean = n != 0
```
pimp my libraryパターン: 既存のクラスにメソッドを追加して拡張する（ようにみせかける）使い方  
```
class RichInt(val self: Int){
    def isPositive: Boolean = self > 0
}
implicit def enrichInt(self: Int): RichInt = new RichInt(self)

// implicit classでかくのが推奨
implicit class RichInt(val self: Int) {
    def isPositive: Boolean = self > 0
} 
```

[参照](https://qiita.com/miyatin0212/items/f70cf68e89e4367fcf2e)  
[公式ドキュメント](https://docs.scala-lang.org/ja/tour/implicit-parameters.html)

- 暗黙のパラメータ  
implicit を変数につけることで、暗黙的に引数として渡すことができる  
```
implicit val context = 1
def printContext(implicit ctx: Int): Unit = {
    println(ctx)
}
```

- implicity について  
親クラスの暗黙の変数を取り出すことができる  
[参照](https://qiita.com/someone7140/items/4ceb041f0a4518ae5300)  

- Futureについて  
非同期に処理される結果が入ったOption型のようなもの  
Try型が入り、処理が終わった時に作動するコールバック関数を用意しておく  
```
val successFuture = Future[Int] { 100 }

val failFuture = Future {
    throw new RuntimeException("失敗じゃ")
}

successFuture.onComplete { // Futureの完了時にコールバックを渡せます
    case Success(intValue) => println(s"future success: ${intValue}")
    case Failure(_) => sys.error("ここに来ることはないだろう...")
}

failFuture.onComplete {
    case Success(_) => sys.error("ここに来ることはないだろう...")
    case Failure(exception) => println(s"future fail: ${exception}")
}

// successfulメソッド、failedメソッドで新たにFuture型を作成できる
val future = Future.successful(2)
future.onComplete {
  case Success(result) => println(result)
  case Failure(t) =>
}

// Filureの場合に、Successのとして扱えるようにする
val Future(throw new IllegalArgumentException())
    .recover{
        case e: IllegalArgumentException => 0
    }

```
Await.resultで、Futureの処理を指定した時間だけ待つことが可能  
```
Await.result(future, 10 seconds)
```

- mainクラス  
sbtによる実行ではmainクラスを実行する  
def main(args: Array[String])の形をした部分  
main関数を定義していなくても、Appトレイトを継承していてもよい  

