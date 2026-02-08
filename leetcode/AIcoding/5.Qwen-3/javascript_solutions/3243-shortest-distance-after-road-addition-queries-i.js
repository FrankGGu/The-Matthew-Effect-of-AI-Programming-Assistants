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
        if (rootX !== rootY) {
            parent[rootY] = rootX;
        }
    }

    const result = [];

    for (const [u, v] of queries) {
        union(u, v);
        let distance = 0;
        let current = n - 1;
        while (current !== 0) {
            current = find(current);
            if (current === 0) break;
            distance++;
            current--;
        }
        result.push(distance);
    }

    return result;
}