function TreeNode(val, left, right) {
    this.val = (val === undefined ? 0 : val);
    this.left = (left === undefined ? null : left);
    this.right = (right === undefined ? null : right);
}

var rootEqualsSumOfChildren = function(root) {
    return root.val === (root.left ? root.left.val : 0) + (root.right ? root.right.val : 0);
};