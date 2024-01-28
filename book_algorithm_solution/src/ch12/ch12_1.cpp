#include <iostream>
#include <vector>
using namespace std;

void InsertSort(vector<int> &a) {
    int N = (int)a.size();
    for (int i = 1; i< N; ++i) {
        int v = a[i];

        int j = i;
        for (; j > 0; --j) {
            if (a[j-1] > v) {
              a[j] = a[j - 1];
            }
            else
              break;
        }
        a[j] = v;
    }
}

int main() {
    int N;
    cin >> N;
    vector<int> a(N);
    for (int i=0; i < N; ++i) cin >> a[i];

    InsertSort(a);

    for (int i = 0; i < N; ++i) cout << a[i] << " ";
}