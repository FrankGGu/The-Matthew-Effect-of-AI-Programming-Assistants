function minWeightedSubgraphWithRequiredPaths(n, edges, src1, src2, dest) {
    const graph = new Array(n).fill(0).map(() => []);
    for (const [u, v, w] of edges) {
        graph[u].push([v, w]);
        graph[v].push([u, w]);
    }

    function dijkstra(start) {
        const dist = new Array(n).fill(Infinity);
        dist[start] = 0;
        const pq = [[0, start]];
        while (pq.length > 0) {
            const [d, u] = pq.shift();
            if (d > dist[u]) continue;
            for (const [v, w] of graph[u]) {
                if (dist[v] > d + w) {
                    dist[v] = d + w;
                    pq.push([dist[v], v]);
                }
            }
        }
        return dist;
    }

    const dist1 = dijkstra(src1);
    const dist2 = dijkstra(src2);
    const distDest = dijkstra(dest);

    let result = Infinity;

    for (let i = 0; i < n; i++) {
        const total = dist1[i] + dist2[i] + distDest[i];
        if (total < result) {
            result = total;
        }
    }

    return result;
}