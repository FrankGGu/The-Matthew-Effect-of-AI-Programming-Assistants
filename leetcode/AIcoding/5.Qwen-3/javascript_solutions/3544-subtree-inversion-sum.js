function invertTree(root) {
    if (root === null) return root;
    const temp = root.left;
    root.left = root.right;
    root.right = temp;
    invertTree(root.left);
    invertTree(root.right);
    return root;
}

function isSubtree(s, t) {
    if (!s) return false;
    if (isSameTree(s, t)) return true;
    return isSubtree(s.left, t) || isSubtree(s.right, t);
}

function isSameTree(s, t) {
    if (!s && !t) return true;
    if (!s || !t) return false;
    return s.val === t.val && isSameTree(s.left, t.left) && isSameTree(s.right, t.right);
}

function subtreeSum(root) {
    if (!root) return 0;
    return root.val + subtreeSum(root.left) + subtreeSum(root.right);
}

function findSubtreeInversionSum(s, t) {
    const invertedT = invertTree(t);
    return subtreeSum(s) - subtreeSum(invertedT);
}