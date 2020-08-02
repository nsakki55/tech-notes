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
  
  
