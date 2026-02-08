function TreeNode(val) {
    this.val = val;
    this.left = null;
    this.right = null;
}

var longestUnivaluePath = function(root) {
    let maxPath = 0;

    function dfs(node) {
        if (!node) return 0;

        let left = dfs(node.left);
        let right = dfs(node.right);

        let leftLength = (node.left && node.left.val === node.val) ? left + 1 : 0;
        let rightLength = (node.right && node.right.val === node.val) ? right + 1 : 0;

        maxPath = Math.max(maxPath, leftLength + rightLength);

        return Math.max(leftLength, rightLength);
    }

    dfs(root);
    return maxPath;
};