function minWeightedSubgraphWithRequiredPaths(n, edges, src1, src2, dest, target) {
    const graph = Array.from({ length: n }, () => []);
    for (const [u, v, w] of edges) {
        graph[u].push([v, w]);
        graph[v].push([u, w]);
    }

    function dijkstra(start) {
        const dist = Array(n).fill(Infinity);
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

    const distFromSrc1 = dijkstra(src1);
    const distFromSrc2 = dijkstra(src2);
    const distFromDest = dijkstra(dest);

    let result = Infinity;

    for (let i = 0; i < n; i++) {
        if (distFromSrc1[i] + distFromSrc2[i] + distFromDest[i] <= target) {
            result = Math.min(result, distFromSrc1[i] + distFromSrc2[i] + distFromDest[i]);
        }
    }

    return result === Infinity ? -1 : result;
}