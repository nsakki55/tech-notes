#include <iostream>
#include <vector>
#include <algorithm>
using namespace std;
using Graph = vector<vector<int>>;

vector<bool> seen;
vector<int> order;
void rec(const Graph &G, int v) {
  seen[v] = true;
  for (auto next_v : G[v]) {
    if (seen[next_v]) continue;
    rec(G, next_v);
  }
  order.push_back(v);
};

int main() {
    int N, M;
    cin >> N >> M;

    Graph G(N);
    for (int i = 0; i < M; i++) {
        int a, b;
        cin >> a >> b;
        G[a].push_back(b);
    }

    seen.assign(N, false);
    order.clear();
    for (int v = 0; v < N; ++v) {
      if (seen[v]) continue;
      rec(G, v);
    }
    reverse(order.begin(), order.end());

    for (auto v: order) cout << v << " -> ";
    cout << endl;
}
