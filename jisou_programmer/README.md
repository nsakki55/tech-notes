# 自走プログラマー
自分に特に必要だと思った内容をまとめる  

作者　要点まとめ  
https://github.com/beproud/jisou-programmer-excerption  
　　
## chapter 1
- 関数名から想像できる型の戻り値を返す  
is_, has_で始まる関数の場合はboolean型を返すようにする  

- 副作用のない関数にまとめる  
関数内で、変数の値を変えるなど、想像できない操作を加えない  

- リストや辞書を関数のデフォルト引数にしない  
pythonでは引数の値は関数の呼び出しのたびし初期化されないので、予期せぬ挙動になりやすい  

- 関数の引数をコレクションにせず、int, strを受け取るようにする  
特定のキーをもつ辞書型や、リストにすると、関数を利用する際にデータ構造を用意する必要があり、再利用性が下がる  

- リストのindexに意味を持たせない  
例えば、indexが2の要素がIDなどにしてコードを書かない。辞書やクラスで管理する、  
```
@dataclass
class Sale:
    sale_id: int
    item_id: int
    user_id: int

def validate_sales(sale):
    if not item_exists(sale.item_id):
        rasie ...
    if sale.amount < 1:
        raise ...

# ダメな例
for idx in range(len(items)):
    items[idx]

# いい例
for n, item in enumerate(items):
    item
```

- コメントには処理内容を書くのではなく、「なぜ」を書く  
何をしているかは、処理が複雑な場合に書く  

- controllerには具体的な実装は書かない  
単体テストが難しくなるので、別の関数に移植する  

- 特定のキーを持つ辞書ではなくクラスを定義する  
特定のキーを持つ辞書を作ると、キーが存在するかのチェックや、他の形式の辞書でつかない関数ができあがるので、再利用性が低い  

- dataclass  
Python3.7から使えるdataclassを使うと、__init__メソッドが長くなるのを防げる  

```
from dataclasses import dataclass
@dataclass
class User:
    username: str
    email: str
    last_name: str
```
- propertyデコレータを使う  
他のメソッドに渡すためだけに属性を作成するのは、メソッド間に依存関係をもたらすのでよくない  
```
class User: 
    def __init__(self, username, birthday):
        self.usernanem = username
        self.birthday = birthday
    
    @property
    def age(self):
        today = date.today()
        age = (self.birthday - today).year
        if (self.birthday.moth, self.birthday.day) < (today.month, today.day):
            age -= 1
        return age
    
    def age_dislplay(self):
        return f"(self.age)" 
```
- 1つのテストメソッドには、1つの項目のみを確認する  

```
def validate(text):
    return 0 < len(text) < 100

class TestValidate:
    def test_valid(self):
        assert validate("a")
        assert validate("a" * 50)
        assert validate("a" * 100)
    
    def test_invalid_too_short(self):
        assert not valiate("")
    
    def test_invalid_too_long(self):
        assert not validate("a" * 101)
```

- テストコードは準備、実行、検証に分割する  
コードが各ブロックどの操作に対応するか分かりやすく書く.  

- テストしやすいように、細かい条件や分岐の処理を別の関数にする  
テストをよりよく描こうとするのではなく、実装の設計を見直す  
全体を通す処理は、文技を網羅するテストメソッドで十分とする  

- テストから外部環境への依存を排除する  
requestライブラリで取得した値をテストするような場合は、モックを使用する  
responsesの使用. requestの模擬応答を行える  


- テスト用の一時ファイルは、テスト後に削除するようにする  
tempfileモジュールのNamedTemporaryFileを使用すると、一時ファイルを作成できる  

- テストケースごとにテストデータを用意する  
テストデータを作成するスクリプトを書いて、他のテストと使い回すと、  
思わぬエラーを吐かれることがあるので、使いまわさない  

- 単体テスト間のでデータの共有を行わない  
各メソッド間でデータを使い回し依存関係を作ると、変更によりエラーが生じやすくなる  
```
import pytest

class TestSum(object):
    def test_sum(self):
        assert sum([0, 1, 2, 3, 4]) == 10
    
    def test_negative(self):
       assert sum([0, 1, 2, 3, 4, -5]) == 5
```

- 戻り値がリストの関数のテストの場合、要素数をテストする  

```
def load_item():
    return [{"id": 1, "name": 'coffee'}, {"id": 2, "name": 'tea'}

class TestLoadItem(object):
    def test_load(self):
        actual = load_item()
        assert len(actual) == 2
        assert acutual[0] == {"id": 1, "name": 'coffee'}
```

- 公式ドキュメントをまずは読む癖をつける  
わからないことは公式ドキュメントをみて、原理や概念の理解をする意識を強く持つ  
キーワードでしらべ、なければ用語集から辿っていく  
調べるときは「15分だけ」というように、時間を決めてから調べるようにする  

- 全体実装の前に、細部の実装予定部分をTODOで記述する  
一気に全体を実装するのではなく、初めにTODOで細かい処理の流れを記述して、  
実装の根拠となるURLなどをコメントに記述していく  

- 必要十分の機能だけをつける  
不必要に拡張性をあげるようなメソッドを作らない。  
特定の操作だけ行えることがわかれば、後から変更しやすくなる  
https://postd.cc/the-sorrows-of-young-developer/  

-  コーディングスタイルに気をつける  
PEP8の規約にのっとってコードを記述する  
https://pep8-ja.readthedocs.io/ja/latest/  

## chapter3
- 例外を握り潰さない  
例外を吐かないように意図的にコードを改良しない  

- try文は短く書く  
try文の処理が複数ある場合だと、どこがエラーがになっているのかわからなくなる。  
処理ごとtry文を記述してエラーを投げるように変更を行う。  

- 自作の例外クラスを作成して、エラーの種類がわかるようにする  

```
class MailReceivingError(Exception):
    pretext = ''
    def __init__(self, messge, *args):
        if self.pretext:
            message = f"(self.pretext): (message)"
        super().__init__(message,  *args)

class MailConnectionError(MailReceivingError):
    pretext = 'connection error'

class MailHeaderError(MailReceivingError):
    pretext = 'header error'
```

- トラブル解決に役立つログを出力する  
処理の開始、終了のみを記述するログは役に立たない  
各処理を特徴付ける変数の値や、時間を出力するようにする  
Tracebackをログに出力させるのはベストプラクティス  
ログのレベル、時刻は最低限出力する  

- 個別の名前でロガーを作らない  
ロガーはモジュールパスを使って取得する   
pythonでは「.」区切りで上位のロガーが適応される  
```
logger = logging.getLogger(__name__)

logging.config.dictConfig({
    'loggers': {
        'product.views': {},
        'product.management.commands': {},
    }
})
``` 
- loggerのレベルの設定をする  
全てのログをinfoで出力するのではなく、プログラムのエラーとしての重要度に応じてレベルを設定する  

- loggerに書き込む内容は5W1Hを意識する  
データを１行ずつ読み込んで処理する場合は、何行目のどんなデータに対してなんの処理を行ったのかが  
わかるようにログを残しておく

```
def main():
    try:
        logger.info("売上CSV取り込み処理開始")

        sales_data = load_sales_csv()
        logger.info("売上CSV読み込み済み")

        for code, sales_rows in sales_data:
            logger.info("取り込み開始 - 店舗コード: %s, データ件数: %s", code, len(sales_rows))
            try:
                for i, row in enumerate(sales_rows, start=1):
                    logger.debug("取り込み処理中 - 店舗(%s): %s行目", code, i)
                    ...
            except Exception as exc:
                logger.warning("取り込み時エラー - 店舗(%s) %s行目: エラー %s", code, i, exc, exc_info=True)
                continue
            logger.info("取り込み正常終了 - 店舗コード: %s", code)

        logger.info("売上CSV取り込み処理終了")
    except Exception as exc:
        logger.error("売上CSV取り込み処理で予期しないエラー発生: エラー %s", exc, exc_info=True)
```

## chapter4
- ファイルパスはプログラムからの相対パスで組み立てる  
ファイルを移動すると実行できなくならないように、パスは相対パスを用いる  


## loggingの設定
logging.config.dictConfig  
https://ahyt910.hateblo.jp/entry/2019/04/16/170339    

## Pythonライブラリ
まずは「枯れている」ライブラリを選択するのが定石  
https://github.com/vinta/awesome-python  

## 一時ファイルの作成  
tempfile  
https://docs.python.org/ja/3/library/tempfile.html  

## 
  
  
