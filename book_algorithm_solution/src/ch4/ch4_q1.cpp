#include <iostream>
using namespace std;

int tribo(int N) {
  cout << "fibo(" << N << ") を呼び出しました" << endl;
  if (N==0) return 0;
  else if (N==1) return 0;
  else if (N==2) return 1;

  int result = tribo(N - 1) + tribo(N - 2) + tribo(N-3);
  cout << N << "項目=" << result << endl;

  return result;
}

int main() { tribo(6); }