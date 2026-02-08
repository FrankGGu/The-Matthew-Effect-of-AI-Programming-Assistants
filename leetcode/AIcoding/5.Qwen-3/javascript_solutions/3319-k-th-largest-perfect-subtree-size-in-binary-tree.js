function kthLargestPerfectSubtreeSize(root, k) {
    const sizes = [];

    function dfs(node) {
        if (!node) return 0;

        const left = dfs(node.left);
        const right = dfs(node.right);

        if (left === right && left !== -1) {
            sizes.push(left + 1);
            return left + 1;
        } else {
            return -1;
        }
    }

    dfs(root);
    sizes.sort((a, b) => b - a);
    return sizes[k - 1] || 0;
}