#include <iostream>
#include <vector>
using namespace std;

template<class T> void chmin(T& a, T b) {
    if (a > b) a = b;
}

int main() {
    int N, W;
    cin >> N >> W;
    vector<int int > a;
    for(int i = 0; i < N; ++i) cin >> a[i];
    vector<vector<bool>> dp(N, vector<bool>(W+1, false));
    dp[0][0] = true;

    for (int i = 0; i < N; ++i) {
        for (int j = 0; j < W; ++j) {
            // a[i]を選ばない場合
            if (dp[i][j]) dp[i+1][j] = true;
            // a[i]を選ぶ場合
            if (j + a[i] <= W) dp[i+1][j + a[i]] = true;
        }
    }
    int res = 0;
    for (int j=0; j <= W; ++j) if (dp[N][j]) res++;
    cout << res << endl;

}
