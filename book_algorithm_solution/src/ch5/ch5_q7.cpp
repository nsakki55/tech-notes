#include <iostream>
#include <vector>
using namespace std;

template<class T> void chmin(T& a, T b) {
    if (a > b) a = b;
}

// 無限大を表す値
const int INF = 1<<29;

int main() {
    int N, W;
    cin >> N >> W;
    vector<int int > a(N), m(N);
    for(int i = 0; i < N; ++i) cin >> a[i] >> m[i];

    // DP
    vector<vector<int>> dp(N, vector<int>(W+1, INF));

    // 初期条件
    dp[0][0] = 0;

    for (int i = 0; i < N; ++i) {
        for (int j = 0; j < W; ++j) {
            // i 個ですでに j が作れる場合
            if (dp[i][j] < INF) chmin(dp[i+1][j], 0)
            
            // i+1 個で m[i] 個未満で j-a[i] が作れるなら j も作れる
            if (j >= a[i] && dp[i+1][j-a[i]]) dp[i+1][j] = true;
        }
    }
    if (dp[N][W]) cout << 'Yes' << endl;
    else cout << 'No' << endl; 

}
