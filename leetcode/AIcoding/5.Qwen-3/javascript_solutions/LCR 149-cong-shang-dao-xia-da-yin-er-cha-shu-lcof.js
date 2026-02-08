function decorateRecord(root) {
    if (!root) return 0;
    let queue = [root];
    let result = 0;
    while (queue.length > 0) {
        let levelSize = queue.length;
        for (let i = 0; i < levelSize; i++) {
            let node = queue.shift();
            result++;
            if (node.left) queue.push(node.left);
            if (node.right) queue.push(node.right);
        }
    }
    return result;
}