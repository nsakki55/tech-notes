#include <iostream>
#include <vector>
using namespace std;
const int INF = 20000000; // 20億

int main() {
    int N;   
    cin >> N;
    vector<int> a(N);
    for (int i=0; i < N; ++i) cin >> a[i];

    int min_value = INF;
    for (int i = 0; i < N; i++) {
        if (a[i]<min_value) {
            min_value = a[i];
        }
    }

    cout << min_value << endl;
}