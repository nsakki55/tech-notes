#include <iostream>
#include <vector>
using namespace std;
const int INF = 20000000; // 20億

int main() {
    int N;   
    cin >> N;
    vector<int> a(N);
    for (int i=0; i < N; ++i) cin >> a[i];

    int second_number = 100;
    int min_number = INF;
    for (int i = 0; i < N; i++) {
        cout << "a[i]: " << a[i] << endl;
        cout << "min_number: " << min_number << endl;
        cout << "second_number: " << second_number << endl;
        
        // 最小値が更新された場合
        if (a[i] < min_number) {
            second_number = min_number;
            min_number = a[i];
        }
        else if (a[i] < second_number) {
            second_number = a[i];
        }
    }

    cout << second_number << endl;
}