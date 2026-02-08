function maxPathQuality(colors, edges, bob) {
    const n = colors.length;
    const graph = Array.from({ length: n }, () => []);
    for (const [u, v] of edges) {
        graph[u].push(v);
        graph[v].push(u);
    }

    let max = 0;
    const visited = new Set();

    function dfs(node, time, score, isBob) {
        if (isBob) {
            if (time > bob[node]) return;
            if (time < bob[node]) {
                score -= colors[node];
            }
        } else {
            score += colors[node];
        }

        if (visited.has(node)) return;
        visited.add(node);

        if (node === 0) {
            max = Math.max(max, score);
        }

        for (const neighbor of graph[node]) {
            dfs(neighbor, time + 1, score, isBob);
        }

        visited.delete(node);
    }

    dfs(0, 0, 0, false);

    return max;
}