var isBalanced = function(root) {
    function getHeight(node) {
        if (!node) return 0;
        const leftHeight = getHeight(node.left);
        const rightHeight = getHeight(node.right);
        if (leftHeight === -1 || rightHeight === -1 || Math.abs(leftHeight - rightHeight) > 1) {
            return -1;
        }
        return Math.max(leftHeight, rightHeight) + 1;
    }
    return getHeight(root) !== -1;
};