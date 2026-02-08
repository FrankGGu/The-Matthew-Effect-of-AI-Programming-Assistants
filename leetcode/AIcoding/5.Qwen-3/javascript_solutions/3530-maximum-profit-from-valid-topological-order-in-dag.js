function maxProfitAssignment(n, edges) {
    const graph = Array.from({ length: n }, () => []);
    const inDegree = Array(n).fill(0);

    for (const [u, v] of edges) {
        graph[u].push(v);
        inDegree[v]++;
    }

    const queue = [];
    for (let i = 0; i < n; i++) {
        if (inDegree[i] === 0) {
            queue.push(i);
        }
    }

    const dp = Array(n).fill(1);
    let result = 0;

    while (queue.length > 0) {
        const u = queue.shift();
        result = Math.max(result, dp[u]);

        for (const v of graph[u]) {
            dp[v] = Math.max(dp[v], dp[u] + 1);
            inDegree[v]--;
            if (inDegree[v] === 0) {
                queue.push(v);
            }
        }
    }

    return result;
}