#include <iostream>
#include <vector>
using namespace std;

struct Edge {
  int to;    // 隣接頂点番号
  long long weight;  // 重み
  Edge(int t, long long w) : to(t), weight(w) {}
};

using Graph = vector<vector<Edge>>;

int main() {
  int N, M;
  cin >> N >> M;  // 頂点数と辺数

  Graph G(N);  // グラフ
  for (int i = 0; i < M; ++i) {
    int a, b;
    long long w;
    cin >> a >> b >> w;
    G[a].push_back(Edge(b, w));
  }
}