#include <iostream>
#include <vector>
using namespace std;
const int INF = 20000000;  // 20億

int main() {
  int N, K;
  cin >> N >> K;
  vector<int> a(N);

  int counter = 0;

  for (int x = 0; x < min(N, K); x++) {
    for (int y = 0; y < min(N, K); ++y) {
      int z = N - x - y;

      if (0 <= z & z <= K) counter += 1;
    }
  }

  cout << counter << endl;
}