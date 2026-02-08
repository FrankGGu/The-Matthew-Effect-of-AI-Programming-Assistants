function collectCoins(n, edges) {
    if (n === 1) return 0;

    const graph = Array.from({ length: n }, () => []);
    for (const [u, v] of edges) {
        graph[u].push(v);
        graph[v].push(u);
    }

    let leaves = [];
    for (let i = 0; i < n; i++) {
        if (graph[i].length === 1) {
            leaves.push(i);
        }
    }

    let remainingNodes = n;
    for (let i = 0; i < 2; i++) {
        if (leaves.length === 0) break;
        const newLeaves = [];
        for (const leaf of leaves) {
            for (const neighbor of graph[leaf]) {
                if (graph[neighbor].length > 1) {
                    const index = graph[neighbor].indexOf(leaf);
                    graph[neighbor].splice(index, 1);
                    if (graph[neighbor].length === 1) {
                        newLeaves.push(neighbor);
                    }
                }
            }
        }
        leaves = newLeaves;
        remainingNodes -= leaves.length;
    }

    return Math.max(0, remainingNodes - 1);
}