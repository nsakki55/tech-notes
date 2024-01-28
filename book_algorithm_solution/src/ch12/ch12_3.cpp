#include <iostream>
#include <vector>
using namespace std;

void QuickSort(vector<int> &a, int left, int right) {
  if (right - left <= 1) return;

  int pivot_index = (left + right) / 2;
  int pivot = a[pivot_index];
  swap(a[pivot_index], a[right - 1]);

  int i = left;
  for (int j = left; j < right - 1; ++j) {
    if (a[j] < pivot) {
      swap(a[i++], a[j]);
    }
  }
  swap(a[i], a[right- 1]);

  QuickSort(a, left, i);
  QuickSort(a, i + 1, right);

}

int main() {
  int N;
  cin >> N;
  vector<int> a(N);
  for (int i = 0; i < N; ++i) cin >> a[i];

  QuickSort(a, 0, N);

  for (int i = 0; i < N; ++i) cout << a[i] << " ";
}