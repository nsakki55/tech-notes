def h(a, b=1, c=1):
    return a * 100 + b * 10 + c


print(h(1, 2, 3))  # 引数3つとも指定 => 123
print(h(2))  # 引数1つだけ指定（b, cはデフォルト値）=> 211
print(h(2, c=2))  # 1つめの引数とcを指定、bはデフォルト値 => 212
print(h(a=2, c=3))  # aの値も明示的に指定することができる => 213
print(h(b=2, a=1, c=3))  # 名前付きで引数を与える場合は順番は自由である => 123