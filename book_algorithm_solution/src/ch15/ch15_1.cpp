#include <iostream>
#include <vector>
#include <algorithm>
using namespace std;

using Edge = pair<int, pair<int, int>>;  // 重み、頂点番号

struct UnionFind {
  vector<int> par, siz;

  UnionFind(int n) : par(n, -1), siz(n, 1) {}

  int root(int x) {
    if (par[x] == -1)
      return x;
    else
      return par[x] = root(par[x]);
  }

  bool issame(int x, int y) { return root(x) == root(y); }

  bool unite(int x, int y) {
    x = root(x); y = root(y);

    if (x == y) return false;

    if (siz[x] < siz[y]) swap(x, y);

    par[y] = x;
    siz[x] += siz[y];
    return true;
  }

  int size(int x) { return siz[root(x)]; }
};

int main() {
  int N, M;
  cin >> N >> M;  // 頂点数と辺数

  vector<Edge> edges(M);  // 辺
  for (int i = 0; i < M; ++i) {
    int u, v, w;
    cin >> u >> v >> w;
    edges[i] = Edge(w, make_pair(u, v));
  }

  // 辺を重みが小さい順にソートする
  sort(edges.begin(), edges.end());

  long long res = 0;
  UnionFind uf(N);
  // クラスカル法
  for (int i = 0; i < M; ++i) {
    int w = edges[i].first;
    int u = edges[i].second.first;
    int v = edges[i].second.second;

    // 辺(a, b)の追加によってサイクルが形成される場合は追加しない
    if (uf.issame(u, v)) continue;

    res += w;
    uf.unite(u, v);
  }

  cout << res << endl;
}