function shortestCycle(graph) {
    const n = graph.length;
    let minCycle = Infinity;

    for (let i = 0; i < n; i++) {
        const dist = new Array(n).fill(-1);
        const queue = [];

        dist[i] = 0;
        queue.push(i);

        while (queue.length > 0) {
            const u = queue.shift();
            for (const v of graph[u]) {
                if (dist[v] === -1) {
                    dist[v] = dist[u] + 1;
                    queue.push(v);
                } else if (dist[v] >= dist[u]) {
                    minCycle = Math.min(minCycle, dist[u] + dist[v] + 1);
                }
            }
        }
    }

    return minCycle === Infinity ? -1 : minCycle;
}