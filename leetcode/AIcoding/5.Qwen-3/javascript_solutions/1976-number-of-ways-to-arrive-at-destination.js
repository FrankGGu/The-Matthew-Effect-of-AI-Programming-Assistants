function countPaths(n, roads) {
    const MOD = 10 ** 9 + 7;
    const graph = Array.from({ length: n }, () => []);
    for (const [u, v, t] of roads) {
        graph[u].push([v, t]);
        graph[v].push([u, t]);
    }

    const dist = Array(n).fill(Infinity);
    const ways = Array(n).fill(0);
    dist[0] = 0;
    ways[0] = 1;

    const pq = new MinPriorityQueue();
    pq.enqueue(0, 0);

    while (!pq.isEmpty()) {
        const [node, currentDist] = pq.dequeue();

        if (currentDist > dist[node]) continue;

        for (const [neighbor, time] of graph[node]) {
            if (dist[neighbor] > dist[node] + time) {
                dist[neighbor] = dist[node] + time;
                ways[neighbor] = ways[node];
                pq.enqueue(neighbor, dist[neighbor]);
            } else if (dist[neighbor] === dist[node] + time) {
                ways[neighbor] = (ways[neighbor] + ways[node]) % MOD;
            }
        }
    }

    return ways[n - 1];
}