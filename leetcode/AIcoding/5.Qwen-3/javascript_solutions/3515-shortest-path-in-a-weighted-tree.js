function shortestPathInWeightedTree(root, target) {
    const path = [];
    let found = false;

    function dfs(node, currentPath) {
        if (found || !node) return;
        currentPath.push(node.val);
        if (node.val === target) {
            path.push(...currentPath);
            found = true;
            return;
        }
        dfs(node.left, currentPath);
        dfs(node.right, currentPath);
        currentPath.pop();
    }

    dfs(root, []);
    return path.length - 1;
}