function numberOfWays(edges) {
    const MOD = 1000000007;
    const n = edges.length + 1;
    const adj = Array(n).fill(0).map(() => []);

    for (const [u, v] of edges) {
        adj[u].push(v);
        adj[v].push(u);
    }

    function dfs(u, parent) {
        let res = 1;
        for (const v of adj[u]) {
            if (v !== parent) {
                res = (res * dfs(v, u)) % MOD;
            }
        }
        return res;
    }

    const ways = dfs(0, -1);
    return ways;
}