var postorder = function(root) {
    if (!root) return [];

    let result = [];

    function traverse(node) {
        for (let child of node.children) {
            traverse(child);
        }
        result.push(node.val);
    }

    traverse(root);
    return result;
};