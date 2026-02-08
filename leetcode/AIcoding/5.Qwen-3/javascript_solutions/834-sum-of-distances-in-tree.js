function sumDistance(nums, edges) {
    const n = nums.length;
    const graph = Array.from({ length: n }, () => []);

    for (const [u, v] of edges) {
        graph[u].push(v);
        graph[v].push(u);
    }

    const res = new Array(n).fill(0);
    const count = new Array(n).fill(1);

    function dfs(node, parent) {
        for (const child of graph[node]) {
            if (child !== parent) {
                dfs(child, node);
                count[node] += count[child];
                res[node] += res[child] + count[child];
            }
        }
    }

    function dfs2(node, parent) {
        for (const child of graph[node]) {
            if (child !== parent) {
                res[child] = res[node] - count[child] + (n - count[child]);
                dfs2(child, node);
            }
        }
    }

    dfs(0, -1);
    dfs2(0, -1);

    return res;
}