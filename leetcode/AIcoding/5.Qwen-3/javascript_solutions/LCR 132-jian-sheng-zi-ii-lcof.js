function maxDistance(height, edges) {
    const n = height.length;
    const graph = Array.from({ length: n }, () => []);
    for (const [u, v] of edges) {
        graph[u].push(v);
        graph[v].push(u);
    }

    const dfs = (node, parent) => {
        let max1 = 0, max2 = 0;
        for (const neighbor of graph[node]) {
            if (neighbor === parent) continue;
            const res = dfs(neighbor, node);
            if (res >= max1) {
                max2 = max1;
                max1 = res;
            } else if (res > max2) {
                max2 = res;
            }
        }
        return max1 + 1;
    };

    let result = 0;
    for (let i = 0; i < n; i++) {
        const dist = dfs(i, -1);
        result = Math.max(result, dist);
    }

    return result;
}