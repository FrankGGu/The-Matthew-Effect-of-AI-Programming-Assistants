function secondMinimum(n, roads) {
    const graph = new Array(n + 1).fill(0).map(() => []);
    for (const [u, v] of roads) {
        graph[u].push(v);
        graph[v].push(u);
    }

    const dist1 = new Array(n + 1).fill(Infinity);
    const dist2 = new Array(n + 1).fill(Infinity);

    const pq = [[0, 1]];
    dist1[1] = 0;

    while (pq.length > 0) {
        const [d, u] = pq.shift();

        if (d > dist2[u]) continue;

        for (const v of graph[u]) {
            if (d + 1 < dist1[v]) {
                [dist1[v], dist2[v]] = [d + 1, dist1[v]];
                pq.push([dist1[v], v]);
            } else if (d + 1 > dist1[v] && d + 1 < dist2[v]) {
                dist2[v] = d + 1;
                pq.push([dist2[v], v]);
            }
        }
    }

    return dist2[n] === Infinity ? -1 : dist2[n];
}