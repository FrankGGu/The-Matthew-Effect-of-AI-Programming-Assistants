function regionsBySlashes(grid) {
    const n = grid.length;
    const parent = new Array(n * n).fill(0).map((_, i) => i);

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
            parent[rootX] = rootY;
        }
    }

    for (let i = 0; i < n; i++) {
        for (let j = 0; j < n; j++) {
            const idx = i * n + j;
            if (i > 0) {
                union(idx - n, idx);
            }
            if (j > 0) {
                union(idx - 1, idx);
            }
        }
    }

    let count = 0;
    for (let i = 0; i < n * n; i++) {
        if (find(i) === i) {
            count++;
        }
    }
    return count;
}