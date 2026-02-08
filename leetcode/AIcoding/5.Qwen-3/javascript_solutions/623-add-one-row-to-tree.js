function TreeNode(val, left, right) {
    this.val = (val === undefined ? 0 : val)
    this.left = (left === undefined ? null : left)
    this.right = (right === undefined ? null : right)
}

var addOneRow = function(root, val, depth) {
    if (depth === 1) {
        const newRoot = new TreeNode(val);
        newRoot.left = root;
        return newRoot;
    }

    const queue = [root];
    let currentDepth = 1;

    while (queue.length > 0) {
        const size = queue.length;
        for (let i = 0; i < size; i++) {
            const node = queue.shift();
            if (currentDepth === depth - 1) {
                const left = node.left;
                const right = node.right;
                node.left = new TreeNode(val);
                node.right = new TreeNode(val);
                node.left.left = left;
                node.right.right = right;
            } else {
                if (node.left) queue.push(node.left);
                if (node.right) queue.push(node.right);
            }
        }
        currentDepth++;
    }

    return root;
};