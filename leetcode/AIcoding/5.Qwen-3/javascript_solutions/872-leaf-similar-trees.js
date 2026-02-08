var leafSimilar = function(root1, root2) {
    function getLeaves(node) {
        let leaves = [];
        if (!node) return leaves;
        if (!node.left && !node.right) return [node.val];
        if (node.left) leaves = leaves.concat(getLeaves(node.left));
        if (node.right) leaves = leaves.concat(getLeaves(node.right));
        return leaves;
    }
    return JSON.stringify(getLeaves(root1)) === JSON.stringify(getLeaves(root2));
};