function findCircleNum(adj) {
    const n = adj.length;
    const visited = new Array(n).fill(false);

    function dfs(node) {
        for (let neighbor = 0; neighbor < n; neighbor++) {
            if (adj[node][neighbor] === 1 && !visited[neighbor]) {
                visited[neighbor] = true;
                dfs(neighbor);
            }
        }
    }

    let provinces = 0;

    for (let i = 0; i < n; i++) {
        if (!visited[i]) {
            visited[i] = true;
            dfs(i);
            provinces++;
        }
    }

    return provinces;
}