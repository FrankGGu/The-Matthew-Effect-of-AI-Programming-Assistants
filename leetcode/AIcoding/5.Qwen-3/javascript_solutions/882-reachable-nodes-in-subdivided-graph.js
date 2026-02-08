function reachableNodes(edges, M, N) {
    const graph = new Map();
    for (const [u, v, w] of edges) {
        if (!graph.has(u)) graph.set(u, []);
        if (!graph.has(v)) graph.set(v, []);
        graph.get(u).push([v, w]);
        graph.get(v).push([u, w]);
    }

    const dist = new Array(N).fill(0);
    const visited = new Set();

    const heap = [[0, 0]];
    while (heap.length > 0) {
        const [d, u] = heap.shift();
        if (visited.has(u)) continue;
        visited.add(u);
        dist[u] = d;
        if (graph.has(u)) {
            for (const [v, w] of graph.get(u)) {
                if (!visited.has(v)) {
                    heap.push([d + w, v]);
                }
            }
        }
    }

    let result = 0;
    for (const [u, v, w] of edges) {
        const du = dist[u];
        const dv = dist[v];
        if (du === undefined || dv === undefined) continue;
        if (du <= M) result += Math.min(M - du, w);
        if (dv <= M) result += Math.min(M - dv, w);
    }

    return result;
}