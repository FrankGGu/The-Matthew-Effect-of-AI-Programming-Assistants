function isSafe(node, visited, graph) {
    return !visited.has(node);
}

function dfs(node, target, visited, graph) {
    if (node === target) {
        return true;
    }
    visited.add(node);
    for (const neighbor of graph.get(node)) {
        if (isSafe(neighbor, visited, graph)) {
            if (dfs(neighbor, target, visited, graph)) {
                return true;
            }
        }
    }
    return false;
}

function checkIfPrerequisite(n, prerequisites, queries) {
    const graph = new Map();
    for (let i = 0; i < n; i++) {
        graph.set(i, []);
    }
    for (const [u, v] of prerequisites) {
        graph.get(u).push(v);
    }
    const result = [];
    for (const [u, v] of queries) {
        const visited = new Set();
        result.push(dfs(u, v, visited, graph));
    }
    return result;
}