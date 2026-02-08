function validPath(n, edges, source, destination) {
    const graph = new Map();

    for (const [u, v] of edges) {
        if (!graph.has(u)) graph.set(u, []);
        if (!graph.has(v)) graph.set(v, []);
        graph.get(u).push(v);
        graph.get(v).push(u);
    }

    const visited = new Set();
    const stack = [source];

    while (stack.length > 0) {
        const node = stack.pop();
        if (node === destination) return true;
        if (visited.has(node)) continue;
        visited.add(node);
        for (const neighbor of graph.get(node) || []) {
            stack.push(neighbor);
        }
    }

    return false;
}