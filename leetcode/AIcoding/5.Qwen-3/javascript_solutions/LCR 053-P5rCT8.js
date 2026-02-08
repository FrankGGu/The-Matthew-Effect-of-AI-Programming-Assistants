var inorderSuccessor = function(root, p) {
    let successor = null;
    while (root) {
        if (root.val > p.val) {
            successor = root;
            root = root.left;
        } else {
            root = root.right;
        }
    }
    return successor;
};