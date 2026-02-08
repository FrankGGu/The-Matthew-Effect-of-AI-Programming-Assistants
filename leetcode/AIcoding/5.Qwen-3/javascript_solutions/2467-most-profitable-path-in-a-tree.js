function minMalwareSpread(grid, initial) {
    const n = grid.length;
    const visited = new Set();

    function dfs(node, mal) {
        if (visited.has(node)) return 0;
        visited.add(node);
        let count = 1;
        for (let neighbor of grid[node]) {
            if (!visited.has(neighbor)) {
                count += dfs(neighbor, mal);
            }
        }
        return count;
    }

    let max = 0;
    let result = initial[0];

    for (let i = 0; i < initial.length; i++) {
        const node = initial[i];
        visited.clear();
        const size = dfs(node, true);
        if (size > max) {
            max = size;
            result = node;
        }
    }

    return result;
}