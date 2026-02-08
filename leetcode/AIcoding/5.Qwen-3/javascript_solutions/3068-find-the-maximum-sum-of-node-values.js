function maximumSum(root) {
    const dfs = (node) => {
        if (!node) return [0, 0];
        const left = dfs(node.left);
        const right = dfs(node.right);
        const pick = node.val + left[1] + right[1];
        const notPick = Math.max(left[0], left[1]) + Math.max(right[0], right[1]);
        return [pick, notPick];
    };
    return Math.max(dfs(root)[0], dfs(root)[1]);
}