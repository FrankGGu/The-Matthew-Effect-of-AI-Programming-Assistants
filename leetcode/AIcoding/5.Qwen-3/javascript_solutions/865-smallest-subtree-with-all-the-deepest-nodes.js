function subtreeWithAllDeepest(root) {
    const dfs = (node) => {
        if (!node) return [null, 0];
        const [left, leftDepth] = dfs(node.left);
        const [right, rightDepth] = dfs(node.right);
        if (leftDepth === rightDepth) {
            return [node, leftDepth + 1];
        } else if (leftDepth > rightDepth) {
            return [left, leftDepth + 1];
        } else {
            return [right, rightDepth + 1];
        }
    };
    return dfs(root)[0];
}