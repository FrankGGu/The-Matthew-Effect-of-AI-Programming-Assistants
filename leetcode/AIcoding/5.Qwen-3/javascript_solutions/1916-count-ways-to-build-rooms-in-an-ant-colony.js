function countWays(roads) {
    const MOD = 10 ** 9 + 7;
    const n = roads.length + 1;
    const graph = Array.from({ length: n }, () => []);

    for (let i = 0; i < roads.length; i++) {
        const [u, v] = roads[i];
        graph[u].push(v);
        graph[v].push(u);
    }

    let result = 1;

    function dfs(node, parent) {
        let size = 1;
        let ways = 1;

        for (const neighbor of graph[node]) {
            if (neighbor === parent) continue;
            const [childSize, childWays] = dfs(neighbor, node);
            size += childSize;
            ways = (ways * childWays) % MOD;
        }

        return [size, ways];
    }

    dfs(0, -1);

    return result;
}