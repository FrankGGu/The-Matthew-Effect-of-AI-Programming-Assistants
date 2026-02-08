function longestCycle(n, edges) {
    const graph = Array.from({ length: n }, () => []);
    for (const [u, v] of edges) {
        graph[u].push(v);
    }

    const visited = new Set();
    let maxCycle = -1;

    for (let i = 0; i < n; i++) {
        if (!visited.has(i)) {
            const map = new Map();
            let node = i;
            let step = 0;
            while (node !== -1 && !visited.has(node)) {
                visited.add(node);
                map.set(node, step++);
                node = graph[node][0];
            }
            if (node !== -1 && map.has(node)) {
                maxCycle = Math.max(maxCycle, step - map.get(node));
            }
        }
    }

    return maxCycle;
}