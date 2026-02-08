function shortestDistanceAfterRoadAdditions(n, queries) {
    const parent = Array.from({ length: n }, (_, i) => i);

    function find(x) {
        while (parent[x] !== x) {
            parent[x] = parent[parent[x]];
            x = parent[x];
        }
        return x;
    }

    function union(x, y) {
        const rootX = find(x);
        const rootY = find(y);
        if (rootX === rootY) return false;
        parent[rootY] = rootX;
        return true;
    }

    const result = [];
    for (const [u, v] of queries) {
        union(u, v);
        let count = 0;
        for (let i = 0; i < n - 1; i++) {
            if (find(i) !== find(i + 1)) {
                count++;
            }
        }
        result.push(count);
    }
    return result;
}