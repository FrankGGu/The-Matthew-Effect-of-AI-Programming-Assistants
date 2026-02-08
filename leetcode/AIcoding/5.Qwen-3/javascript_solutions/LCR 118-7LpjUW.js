function findRedundantConnection(graph) {
    const parent = {};

    function find(x) {
        if (!parent[x]) return x;
        return find(parent[x]);
    }

    function union(x, y) {
        const rootX = find(x);
        const rootY = find(y);
        if (rootX === rootY) return false;
        parent[rootX] = rootY;
        return true;
    }

    for (const [u, v] of graph) {
        if (!union(u, v)) return [u, v];
    }

    return [];
}