function evaluateTree(root) {
    if (root.val === 0 || root.val === 1) {
        return root.val === 1;
    }
    const leftVal = evaluateTree(root.left);
    const rightVal = evaluateTree(root.right);
    if (root.val === 2) {
        return leftVal || rightVal;
    } else {
        return leftVal && rightVal;
    }
}