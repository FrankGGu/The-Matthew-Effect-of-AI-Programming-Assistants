function serialize(root) {
    const result = [];
    const dfs = (node) => {
        if (!node) {
            result.push('null');
            return;
        }
        result.push(node.val);
        dfs(node.left);
        dfs(node.right);
    };
    dfs(root);
    return result.join(',');
}

function deserialize(data) {
    const nodes = data.split(',');
    let index = 0;
    const dfs = () => {
        if (nodes[index] === 'null') {
            index++;
            return null;
        }
        const node = new TreeNode(parseInt(nodes[index]));
        index++;
        node.left = dfs();
        node.right = dfs();
        return node;
    };
    return dfs();
}