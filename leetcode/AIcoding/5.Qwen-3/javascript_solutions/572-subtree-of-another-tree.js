function isSubtree(s, t) {
    if (!s || !t) return false;

    function isSameTree(a, b) {
        if (!a || !b) return a === b;
        return a.val === b.val && isSameTree(a.left, b.left) && isSameTree(a.right, b.right);
    }

    function dfs(node) {
        if (!node) return false;
        if (isSameTree(node, t)) return true;
        return dfs(node.left) || dfs(node.right);
    }

    return dfs(s);
}