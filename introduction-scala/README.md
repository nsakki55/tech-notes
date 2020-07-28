# Scala 入門

## Note
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
