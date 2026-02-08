function findCircleNum(isConnected) {
    const n = isConnected.length;
    const visited = new Array(n).fill(false);

    function dfs(i) {
        for (let j = 0; j < n; j++) {
            if (isConnected[i][j] && !visited[j]) {
                visited[j] = true;
                dfs(j);
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