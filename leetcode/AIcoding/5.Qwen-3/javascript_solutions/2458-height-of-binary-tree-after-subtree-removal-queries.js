function treeQueries(root, queries) {
    const depth = {};
    const height = {};

    function dfs(node) {
        if (!node) return -1;
        const left = dfs(node.left);
        const right = dfs(node.right);
        height[node] = 1 + Math.max(left, right);
        return height[node];
    }

    dfs(root);

    const depthMap = {};
    function dfs2(node, currentDepth, isLeft) {
        if (!node) return;
        depthMap[node] = currentDepth;
        dfs2(node.left, currentDepth + 1, true);
        dfs2(node.right, currentDepth + 1, false);
    }

    dfs2(root, 0, true);

    const map = {};
    function dfs3(node) {
        if (!node) return;
        const left = node.left ? height[node.left] : -1;
        const right = node.right ? height[node.right] : -1;
        map[node] = Math.max(left, right);
        dfs3(node.left);
        dfs3(node.right);
    }

    dfs3(root);

    const result = [];
    for (const q of queries) {
        const d = depthMap[q];
        const h = map[q];
        result.push(d + h);
    }

    return result;
}