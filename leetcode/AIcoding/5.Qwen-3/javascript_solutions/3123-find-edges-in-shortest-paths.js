function findCriticalAndPseudoCriticalEdges(n, edges) {
    const originalEdges = edges.map((e, i) => [e[0], e[1], e[2], i]);

    function kruskal(edges, n, include = -1, exclude = -1) {
        let parent = Array.from({ length: n }, (_, i) => i);

        function find(x) {
            if (parent[x] !== x) parent[x] = find(parent[x]);
            return parent[x];
        }

        function union(x, y) {
            const rootX = find(x);
            const rootY = find(y);
            if (rootX === rootY) return false;
            parent[rootY] = rootX;
            return true;
        }

        let totalWeight = 0;
        let edgeCount = 0;

        for (const [u, v, w, i] of edges) {
            if (i === exclude) continue;
            if (i === include) {
                if (union(u, v)) {
                    totalWeight += w;
                    edgeCount++;
                }
            } else {
                if (union(u, v)) {
                    totalWeight += w;
                    edgeCount++;
                }
            }
        }

        if (edgeCount !== n - 1) return Infinity;
        return totalWeight;
    }

    const sortedEdges = [...originalEdges].sort((a, b) => a[2] - b[2]);
    const minSpanningTreeWeight = kruskal(sortedEdges, n);

    const critical = new Set();
    const pseudoCritical = new Set();

    for (let i = 0; i < edges.length; i++) {
        const weightWithout = kruskal(sortedEdges, n, -1, i);
        if (weightWithout > minSpanningTreeWeight) {
            critical.add(i);
        } else {
            const weightWith = kruskal(sortedEdges, n, i, -1);
            if (weightWith === minSpanningTreeWeight) {
                pseudoCritical.add(i);
            }
        }
    }

    return [Array.from(critical), Array.from(pseudoCritical)];
}