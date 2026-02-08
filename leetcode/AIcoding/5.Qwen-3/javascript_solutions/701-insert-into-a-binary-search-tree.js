var insertIntoBST = function(root, val) {
    if (!root) {
        return new TreeNode(val);
    }

    let current = root;
    while (true) {
        if (val < current.val) {
            if (!current.left) {
                current.left = new TreeNode(val);
                break;
            } else {
                current = current.left;
            }
        } else {
            if (!current.right) {
                current.right = new TreeNode(val);
                break;
            } else {
                current = current.right;
            }
        }
    }

    return root;
};