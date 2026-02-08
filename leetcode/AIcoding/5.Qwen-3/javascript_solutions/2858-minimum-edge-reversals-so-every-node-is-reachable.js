function minEdgeReversals(graph, n) {
    const adj = new Array(n).fill(0).map(() => []);
    for (let i = 0; i < graph.length; i++) {
        const [u, v] = graph[i];
        adj[u].push([v, 0]);
        adj[v].push([u, 1]);
    }

    let res = 0;

    function dfs(node, parent) {
        let count = 0;
        for (const [child, dir] of adj[node]) {
            if (child !== parent) {
                count += dfs(child, node);
                if (dir === 1) {
                    res++;
                }
            }
        }
        return count;
    }

    dfs(0, -1);
    return res;
}