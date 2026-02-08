function countNodes(root) {
    if (root === null) return 0;

    let leftDepth = 0;
    let rightDepth = 0;
    let leftNode = root;
    let rightNode = root;

    while (leftNode !== null) {
        leftNode = leftNode.left;
        leftDepth++;
    }

    while (rightNode !== null) {
        rightNode = rightNode.right;
        rightDepth++;
    }

    if (leftDepth === rightDepth) {
        return Math.pow(2, leftDepth) - 1;
    } else {
        return 1 + countNodes(root.left) + countNodes(root.right);
    }
}