function minCost(root) {
    function dfs(node) {
        if (!node) return [0, 0];
        let [leftMin, leftMax] = dfs(node.left);
        let [rightMin, rightMax] = dfs(node.right);
        let minCost = Math.min(leftMin, rightMin) + node.val;
        let maxCost = Math.max(leftMax, rightMax) + node.val;
        return [minCost, maxCost];
    }
    let [min, max] = dfs(root);
    return max - min;
}