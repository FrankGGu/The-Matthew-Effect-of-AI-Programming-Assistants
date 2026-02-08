function countValidPaths(root) {
    const map = new Map();

    function dfs(node) {
        if (!node) return;
        const path = [];
        let current = node;
        while (current) {
            path.push(current.val);
            current = current.parent;
        }
        const key = path.join(',');
        map.set(key, (map.get(key) || 0) + 1);
        dfs(node.left);
        dfs(node.right);
    }

    function traverse(node) {
        if (!node) return;
        dfs(node);
        traverse(node.left);
        traverse(node.right);
    }

    traverse(root);
    let result = 0;
    for (const count of map.values()) {
        if (count > 1) result += count * (count - 1) / 2;
    }
    return result;
}