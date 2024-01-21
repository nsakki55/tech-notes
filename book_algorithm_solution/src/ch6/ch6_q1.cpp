#include <iostream>
#include <vector>
#include <algorithm>
using namespace std;

int main() {
  int N;
  cin >> N;
  vector<int> a(N);
  for (int i=0; i<N; i++) cin >> a[i];

  auto b = a;
  sort(b.begin(), b.end());

  vector<int> res(N);
  for (int i = 0; i < N; ++i) {
    res[i] = lower_bound(b.begin(), b.end(), a[i]) - b.begin();
  }

    for (int i = 0; i < N; ++i) cout << res[i] << endl;
}
