#include <iostream>
#include <vector>
using namespace std;

template<class T> void chmin(T& a, T b) {
    if (a > b) a = b;
}

int main() {
    int N, W, K;
    cin >> N >> W >> K;
    vector<int> a(N); // Correct the vector declaration and initialize 'a'
    for(int i = 0; i < N; ++i) cin >> a[i];
    vector<vector<bool>>> dp(N+1, vector<bool>(W+1, false)); // Fix the dimensions of 'dp'
    dp[0][0] = 0;

    for (int i = 0; i < N; ++i) {
        for (int j = 0; j <= W; ++j) {
            // a[i]を選ばない場合
            chmin(dp[i+1][j], dp[i][j])
            // a[i]を選ぶ場合
            if (j >= a[i]) chmin(dp[i+1][j], dp[i+1][j-a[i]] + 1)
        }
    }
    if dp[N][W] <= K cout << "Yes" << endl;
    else cout << "No" << endl;

}

// int main() {
//     int N, W, K;
//     cin >> N >> W >> K;
//     vector<int> a(N); // Correct the vector declaration and initialize 'a'
//     for(int i = 0; i < N; ++i) cin >> a[i];
//     vector<vector<vector<bool>>> dp(N+1, vector<vector<bool>>(K+1, vector<bool>(W+1, false))); // Fix the dimensions of 'dp'
//     dp[0][0][0] = true;

//     for (int i = 0; i < N; ++i) {
//         for (int j = 0; j <= W; ++j) {
//             for (int k = 0; k <= K; ++k) {
//             // a[i]を選ばない場合
//             if (dp[i][k][j]) dp[i+1][k][j] = true;
//             // a[i]を選ぶ場合
//             if (j >= a[i] && k > 1 && dp[i][k-1][j-a[i]] ) dp[i+1][k-1][j + a[i]] = true; // Fix the indices
//         }
//     }
//     int res = 0;
//     for (int j=0; j <= W; ++j) if (dp[N][j]) res++;
//     cout << res << endl;

// }
