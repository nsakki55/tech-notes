#include <iostream>
#include <queue>
#include <vector>
using namespace std;

const long long INF = 1LL << 60;  // 十分大きな値とする (ここでは 2^60)

struct Edge {
  int to;       // 隣接頂点番号
  long long w;  // 重み
  Edge(int to, long long w) : to(to), w(w) {}
};

using Graph = vector<vector<Edge>>;

template <class T>
bool chmin(T& a, T b) {
  if (a > b) {
    a = b;
    return true;
  } else
    return false;
}

int main() {
  int N, M, s;
  cin >> N >> M >> s;

  Graph G(N);
  for (int i = 0; i < M; ++i) {
    int a, b, w;
    cin >> a >> b >> w;
    G[a].push_back(Edge(b, w));
  }

  vector<long long> dist(N, INF);
  dist[s] = 0;

  priority_queue<pair<long long, int>, vector<pair<long long, int>>,
                 greater<pair<long long, int>>> que;
  que.push(make_pair(dist[s], s));

  while (!que.empty()) {
    int v = que.top().second;
    long long d = que.top().first;
    que.pop();

    if (dist[v] < d) continue;

    for (auto e : G[v]) {
      if (chmin(dist[e.to], dist[v] + e.w)) {
        que.push(make_pair(dist[e.to], e.to));
      }
    }
  }

  for (int v = 0; v < N; ++v) {
    if (dist[v] < INF)
      cout << dist[v] << endl;
    else
      cout << "INF" << endl;
  }
}