function timeTakenToMarkAllNodes(head) {
    const graph = new Map();

    function buildGraph(node, parent) {
        if (!graph.has(node.val)) {
            graph.set(node.val, []);
        }
        if (parent !== null) {
            graph.get(node.val).push(parent.val);
        }
        if (node.left) {
            graph.get(node.val).push(node.left.val);
            buildGraph(node.left, node);
        }
        if (node.right) {
            graph.get(node.val).push(node.right.val);
            buildGraph(node.right, node);
        }
    }

    buildGraph(head, null);

    const visited = new Set();
    const result = [0];

    function dfs(node, time) {
        visited.add(node);
        result[0] = Math.max(result[0], time);
        for (const neighbor of graph.get(node)) {
            if (!visited.has(neighbor)) {
                dfs(neighbor, time + 1);
            }
        }
    }

    dfs(head.val, 0);

    return result[0];
}