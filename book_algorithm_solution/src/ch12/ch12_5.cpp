#include <iostream>
#include <vector>
using namespace std;

const int MAX = 1000000;

void BucketSort(vector<int> &a) {
  int N = (int)a.size();

  vector<int> num(MAX, 0);
  for (int i = 0; i < N; ++i) ++num[a[i]];

  vector<int> sum(MAX, 0);
  for (int v=1; v < MAX; ++v) sum[v] = sum[v - 1] + num[v - 1];

  vector<int> a2(N);
  for (int i=N-1; i >= 0; --i) a2[--sum[a[i]]] = a[i];

  a = a2;
}

int main() {
  int N;
  cin >> N;
  vector<int> a(N);
  for (int i = 0; i < N; ++i) cin >> a[i];

  BucketSort(a);

  for (int i = 0; i < N; ++i) cout << a[i] << " ";
}