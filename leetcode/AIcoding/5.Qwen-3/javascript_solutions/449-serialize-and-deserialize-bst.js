var serialize = function(root) {
    const result = [];
    const dfs = (node) => {
        if (!node) {
            result.push('null');
            return;
        }
        result.push(node.val.toString());
        dfs(node.left);
        dfs(node.right);
    };
    dfs(root);
    return result.join(',');
};

var deserialize = function(data) {
    const nodes = data.split(',');
    let index = 0;
    const buildTree = () => {
        if (index >= nodes.length) return null;
        const val = nodes[index++];
        if (val === 'null') return null;
        const node = new TreeNode(parseInt(val, 10));
        node.left = buildTree();
        node.right = buildTree();
        return node;
    };
    return buildTree();
};