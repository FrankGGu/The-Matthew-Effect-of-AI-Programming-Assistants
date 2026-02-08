function findCriticalNodes(n, edges) {
    const graph = Array.from({ length: n }, () => []);
    for (const [u, v] of edges) {
        graph[u].push(v);
        graph[v].push(u);
    }

    const result = [];
    const visited = new Set();
    const isEvenDegree = (node) => graph[node].length % 2 === 0;

    function dfs(node, parent) {
        let degree = 0;
        for (const neighbor of graph[node]) {
            if (neighbor === parent) continue;
            degree += dfs(neighbor, node);
        }
        if (degree % 2 === 1) {
            result.push(node);
        }
        return degree + 1;
    }

    dfs(0, -1);

    return result;
}