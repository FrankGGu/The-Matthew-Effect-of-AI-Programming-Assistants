var findBottomLeftValue = function(root) {
    let queue = [root];
    let result = root.val;

    while (queue.length > 0) {
        let levelSize = queue.length;
        for (let i = 0; i < levelSize; i++) {
            let node = queue.shift();
            if (i === 0) {
                result = node.val;
            }
            if (node.left) {
                queue.push(node.left);
            }
            if (node.right) {
                queue.push(node.right);
            }
        }
    }

    return result;
};