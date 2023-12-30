#include <iostream>
#include <vector>
using namespace std;

void func(long long N, long long cur, int use, long long &counter) {
  if (cur > N) return;
  // 7,5,3全てが使われている場合は0b111となる
  if (use == 0b111) ++counter;

  // 現在の数字に7,5,3が含まれるかを判定するために、use | 0b001を使う
  // 例えば3と7が使われている場合は0b101となる
  func(N, cur * 10 + 7, use | 0b001, counter);
  func(N, cur * 10 + 5, use | 0b010, counter);
  func(N, cur * 10 + 3, use | 0b100, counter);
}

int main() {
  long long N;
  cin >> N;
  long long counter = 0;
  func(N, 0, 0, counter);
  cout << counter << endl;

  // cout << (0b100 | 0b001) << endl;
  // cout << (0b111 == 0b010) << endl;
  // cout << (0b110 == 0b111) << endl;
  // cout << (0b111==0b100) << endl;
  // cout << (0b111==0b101) << endl;
}
