var findMode = function(root) {
    let maxCount = 0;
    let currentCount = 0;
    let prevValue = null;
    let result = [];

    const inorder = function(node) {
        if (!node) return;
        inorder(node.left);
        if (node.val === prevValue) {
            currentCount++;
        } else {
            currentCount = 1;
        }
        if (currentCount > maxCount) {
            maxCount = currentCount;
            result = [node.val];
        } else if (currentCount === maxCount) {
            result.push(node.val);
        }
        prevValue = node.val;
        inorder(node.right);
    };

    inorder(root);
    return result;
};