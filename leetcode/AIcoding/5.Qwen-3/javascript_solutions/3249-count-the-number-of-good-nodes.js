var goodNodes = function(root) {
    let count = 0;
    const dfs = (node, maxSoFar) => {
        if (!node) return;
        if (node.val >= maxSoFar) count++;
        dfs(node.left, Math.max(maxSoFar, node.val));
        dfs(node.right, Math.max(maxSoFar, node.val));
    };
    dfs(root, -Infinity);
    return count;
};