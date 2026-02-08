function findValidArrangement(pairs) {
    const graph = new Map();
    const inDegree = new Map();
    const outDegree = new Map();

    for (const [u, v] of pairs) {
        if (!graph.has(u)) graph.set(u, []);
        graph.get(u).push(v);
        outDegree.set(u, (outDegree.get(u) || 0) + 1);
        inDegree.set(v, (inDegree.get(v) || 0) + 1);
    }

    function getStartNode() {
        for (const node of graph.keys()) {
            if (outDegree.get(node) - inDegree.get(node) === 1) return node;
        }
        return pairs[0][0];
    }

    const result = [];

    function dfs(node) {
        while (graph.has(node) && graph.get(node).length > 0) {
            const next = graph.get(node).pop();
            dfs(next);
            result.push([node, next]);
        }
    }

    dfs(getStartNode());

    return result.reverse();
}