function findChampion(n, edges) {
    const inDegree = new Array(n).fill(0);
    const adj = new Array(n).fill(0).map(() => []);

    for (const [u, v] of edges) {
        adj[u].push(v);
        inDegree[v]++;
    }

    const queue = [];
    for (let i = 0; i < n; i++) {
        if (inDegree[i] === 0) {
            queue.push(i);
        }
    }

    let result = -1;
    while (queue.length > 0) {
        const node = queue.shift();
        result = node;
        for (const neighbor of adj[node]) {
            inDegree[neighbor]--;
            if (inDegree[neighbor] === 0) {
                queue.push(neighbor);
            }
        }
    }

    return result;
}