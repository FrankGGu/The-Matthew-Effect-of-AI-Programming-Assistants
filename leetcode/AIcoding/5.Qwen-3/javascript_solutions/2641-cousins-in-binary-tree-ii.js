var isCousins = function(root) {
    const levelMap = new Map();

    const dfs = (node, depth, parentVal) => {
        if (!node) return;
        if (!levelMap.has(depth)) {
            levelMap.set(depth, []);
        }
        levelMap.get(depth).push({ val: node.val, parent: parentVal });
        dfs(node.left, depth + 1, node.val);
        dfs(node.right, depth + 1, node.val);
    };

    dfs(root, 0, null);

    for (const [depth, nodes] of levelMap.entries()) {
        const values = nodes.map(n => n.val);
        const parents = nodes.map(n => n.parent);
        if (values.length === 2 && parents[0] !== parents[1]) {
            return true;
        }
    }

    return false;
};