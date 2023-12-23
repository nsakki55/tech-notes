#include <iostream>
#include <vector>
using namespace std;

int main() {
  int N, v;
  cin >> N >> v;
  vector<int> a(N);

  bool exist = false;
  for (int i = 0; i < N; i++) {
    if (a[i] == v) {
      exist = true;
    }
  }

  if (exist)
    cout << "Yes" << endl;
  else
    cout << "No" << endl;
}