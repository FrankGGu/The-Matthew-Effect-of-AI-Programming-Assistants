function possibleBipartition(spreadsheets) {
    const graph = {};
    for (let i = 0; i < spreadsheets.length; i++) {
        const [u, v] = spreadsheets[i];
        if (!graph[u]) graph[u] = [];
        if (!graph[v]) graph[v] = [];
        graph[u].push(v);
        graph[v].push(u);
    }

    const color = {};

    function dfs(node, c) {
        if (color[node] !== undefined) {
            return color[node] === c;
        }
        color[node] = c;
        for (const neighbor of graph[node]) {
            if (!dfs(neighbor, 1 - c)) {
                return false;
            }
        }
        return true;
    }

    for (const node in graph) {
        if (!color[node] && !dfs(node, 0)) {
            return false;
        }
    }

    return true;
}