function isSubStructure(A, B) {
    if (!A || !B) return false;

    function isSame(a, b) {
        if (!b) return true;
        if (!a) return false;
        return a.val === b.val && isSame(a.left, b.left) && isSame(a.right, b.right);
    }

    function dfs(node) {
        if (!node) return false;
        if (isSame(node, B)) return true;
        return dfs(node.left) || dfs(node.right);
    }

    return dfs(A);
}