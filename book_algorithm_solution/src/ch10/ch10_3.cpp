#include <iostream>
#include <vector>
using namespace std;
using Graph = vector<vector<int>>;

int main() {
  int N, M;
  cin >> N >> M;  // 頂点数と辺数

  Graph G(N);  // グラフ
  for (int i = 0; i < M; ++i) {
    int a, b;
    cin >> a >> b;
    G[a].push_back(b);
  }
}