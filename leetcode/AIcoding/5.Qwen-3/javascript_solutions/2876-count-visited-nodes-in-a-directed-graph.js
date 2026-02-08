function countVisitedNodes(head) {
    const visited = new Set();
    const result = [];

    function dfs(node) {
        if (visited.has(node)) {
            return 0;
        }
        visited.add(node);
        const next = node.next;
        if (next === null) {
            return 1;
        }
        const count = dfs(next);
        result[node.val] = count + 1;
        return count + 1;
    }

    for (let node = head; node !== null; node = node.next) {
        if (!visited.has(node)) {
            dfs(node);
        }
    }

    return result;
}