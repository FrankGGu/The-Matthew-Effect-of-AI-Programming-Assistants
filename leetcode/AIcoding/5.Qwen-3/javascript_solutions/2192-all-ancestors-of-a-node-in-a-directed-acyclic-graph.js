function getAncestors(n, edges) {
    const graph = Array.from({ length: n }, () => []);
    const inDegree = Array(n).fill(0);

    for (const [u, v] of edges) {
        graph[u].push(v);
        inDegree[v]++;
    }

    const result = Array.from({ length: n }, () => new Set());
    const queue = [];

    for (let i = 0; i < n; i++) {
        if (inDegree[i] === 0) {
            queue.push(i);
        }
    }

    while (queue.length > 0) {
        const node = queue.shift();

        for (const neighbor of graph[node]) {
            inDegree[neighbor]--;
            if (inDegree[neighbor] === 0) {
                queue.push(neighbor);
            }

            result[neighbor].add(node);
            for (const ancestor of result[node]) {
                result[neighbor].add(ancestor);
            }
        }
    }

    return result.map(set => Array.from(set).sort((a, b) => a - b));
}