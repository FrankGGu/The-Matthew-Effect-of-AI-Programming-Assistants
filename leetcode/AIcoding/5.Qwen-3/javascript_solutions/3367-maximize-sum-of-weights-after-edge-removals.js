function maxSumAfterEdgeRemoval(n, edges) {
    const graph = new Array(n).fill(0).map(() => []);
    for (const [u, v, w] of edges) {
        graph[u].push([v, w]);
        graph[v].push([u, w]);
    }

    function dfs(node, parent) {
        let total = 0;
        for (const [child, weight] of graph[node]) {
            if (child !== parent) {
                total += dfs(child, node);
            }
        }
        return total;
    }

    const totalSum = dfs(0, -1);

    let maxSum = 0;

    function dfs2(node, parent) {
        let sum = 0;
        for (const [child, weight] of graph[node]) {
            if (child !== parent) {
                const childSum = dfs2(child, node);
                sum += childSum;
                maxSum = Math.max(maxSum, totalSum - childSum);
            }
        }
        return sum;
    }

    dfs2(0, -1);

    return maxSum;
}