#include <iostream>
using namespace std;

int fibo(int N) {
  cout << "fibo(" << N << ") を呼び出しました" << endl;
  if (N==0) return 0;
  else if (N==1) return 1;

  int result = fibo(N - 1) + fibo(N - 2);
  cout << N << "項目=" << result << endl;

  return result;
}

int main() { fibo(6); }