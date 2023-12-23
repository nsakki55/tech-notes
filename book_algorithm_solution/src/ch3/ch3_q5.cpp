#include <iostream>
#include <vector>
using namespace std;
const int INF = 20000000;  // 20億

int main() {
  int N;
  cin >> N;
  vector<int> a(N);
  for (int i = 0; i < N; ++i) cin >> a[i];

  int min_trial = INF;

  for (int i = 0; i < N; i++) {
    bool is_odd = true;
    int trial = 0;
    while (is_odd) {
      if (a[i] % 2 == 0) {
        a[i] = a[i] / 2;
        trial += 1;
      } else {
        is_odd = false;
      }
    }

    if (trial < min_trial) {
      min_trial = trial;
    }
  }

  cout << min_trial << endl;
}