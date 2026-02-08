function connectTrees(root1, root2) {
    const map = new Map();

    function dfs(node) {
        if (!node) return;
        dfs(node.left);
        dfs(node.right);
        map.set(node.val, (map.get(node.val) || 0) + 1);
    }

    dfs(root1);
    dfs(root2);

    let count = 0;
    for (const [val, freq] of map.entries()) {
        if (freq >= 2) count++;
    }

    return count;
}