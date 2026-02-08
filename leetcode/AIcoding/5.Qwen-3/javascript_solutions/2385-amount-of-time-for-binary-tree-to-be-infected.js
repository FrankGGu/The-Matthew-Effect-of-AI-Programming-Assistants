function amountOfTime(root, start) {
    const graph = new Map();

    function buildGraph(node, parent) {
        if (!node) return;
        if (!graph.has(node.val)) graph.set(node.val, []);
        if (parent) {
            graph.get(node.val).push(parent.val);
            graph.get(parent.val).push(node.val);
        }
        buildGraph(node.left, node);
        buildGraph(node.right, node);
    }

    buildGraph(root, null);

    const visited = new Set();
    const queue = [start];
    visited.add(start);
    let time = 0;

    while (queue.length > 0) {
        const size = queue.length;
        for (let i = 0; i < size; i++) {
            const current = queue.shift();
            for (const neighbor of graph.get(current) || []) {
                if (!visited.has(neighbor)) {
                    visited.add(neighbor);
                    queue.push(neighbor);
                }
            }
        }
        time++;
    }

    return time - 1;
}