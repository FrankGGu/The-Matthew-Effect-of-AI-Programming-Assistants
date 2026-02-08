function numberOfWays() {
    const MOD = 10 ** 9 + 7;
    const edges = [[0, 1], [1, 2], [2, 3], [3, 4], [4, 5]];
    const n = 6;

    const adj = new Array(n).fill(0).map(() => []);
    for (const [u, v] of edges) {
        adj[u].push(v);
        adj[v].push(u);
    }

    const parent = new Array(n).fill(-1);
    const depth = new Array(n).fill(0);
    const size = new Array(n).fill(1);

    function dfs(u) {
        for (const v of adj[u]) {
            if (v !== parent[u]) {
                parent[v] = u;
                depth[v] = depth[u] + 1;
                dfs(v);
                size[u] += size[v];
            }
        }
    }

    dfs(0);

    const edgeCount = edges.length;
    const result = new Array(edgeCount).fill(0);

    for (let i = 0; i < edgeCount; i++) {
        const [u, v] = edges[i];
        const isParent = parent[v] === u;
        const childSize = isParent ? size[v] : size[u];
        result[i] = childSize;
    }

    let ans = 1;
    for (let i = 0; i < edgeCount; i++) {
        ans = (ans * result[i]) % MOD;
    }

    return ans;
}