function removeStones(stones) {
    const parent = {};

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

    for (const [x, y] of stones) {
        const row = `row${x}`;
        const col = `col${y}`;
        if (!parent[row]) parent[row] = row;
        if (!parent[col]) parent[col] = col;
        union(row, col);
    }

    const roots = new Set();
    for (const [x, y] of stones) {
        const row = `row${x}`;
        roots.add(find(row));
    }

    return stones.length - roots.size;
}