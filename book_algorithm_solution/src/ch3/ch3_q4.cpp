#include <iostream>
#include <vector>
using namespace std;
const int INF = 20000000; // 20億

int main() {
    int N;   
    cin >> N;
    vector<int> a(N);
    for (int i=0; i < N; ++i) cin >> a[i];

    int min = INF;
    int max = -INF;
    for (int i = 0; i < N; i++) {
        if (a[i] < min) {
            min = a[i];
        }
        else if (max < a[i]) {
            max = a[i];
        }
    }

    cout << max -min << endl;
}