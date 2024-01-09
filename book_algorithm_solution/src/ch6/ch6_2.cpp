#include <iostream>
using namespace std;


bool P(int x) {
  // xが条件を満たすかどうかを判定する
}

int binary_search(int key) {
  int left, right; // P(left) = false, P(right) = trueとなるように

  while (right - left > 1) {
    int mid = left + (right - left) / 2;
    if (P(mid)) right = mid;
    else
      left = mid;
  }
  return right;
}

int main() {
}
