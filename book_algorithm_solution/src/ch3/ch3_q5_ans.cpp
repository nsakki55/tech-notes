#include <iostream>
#include <vector>
using namespace std;
const int INF = 20000000;  // 20億

int how_many_time(int N) {
  int exp = 0;
  while (N % 2 == 0) N = N / 2, exp += 1;
  return exp;
}

int main() {
  int N;
  cin >> N;
  vector<int> A(N);
  for (int i = 0; i < N; ++i) cin >> A[i];

  int min_trial = INF;

  for (auto a : A) {
  // for (int i = 0; i < N; i++) {
    min_trial = min(min_trial, how_many_time(a));
  }

  cout << min_trial << endl;
}