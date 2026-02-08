function countComponents(n, edges) {
    const parent = Array(n).fill(0).map((_, i) => i);

    function find(x) {
        if (parent[x] !== x) {
            parent[x] = find(parent[x]);
        }
        return parent[x];
    }

    function union(x, y) {
        const rootX = find(x);
        const rootY = find(y);
        if (rootX !== rootY) {
            parent[rootY] = rootX;
        }
    }

    for (const [u, v] of edges) {
        union(u, v);
    }

    const roots = new Set();
    for (let i = 0; i < n; i++) {
        roots.add(find(i));
    }

    return roots.size;
}