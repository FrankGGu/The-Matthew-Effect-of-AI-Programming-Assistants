function closestNodes(root, queries) {
    const inorder = [];

    function traverse(node) {
        if (!node) return;
        traverse(node.left);
        inorder.push(node.val);
        traverse(node.right);
    }

    traverse(root);

    const result = [];
    for (const q of queries) {
        let left = 0, right = inorder.length - 1;
        let minVal = -1, maxVal = -1;

        while (left <= right) {
            const mid = Math.floor((left + right) / 2);
            if (inorder[mid] < q) {
                left = mid + 1;
            } else {
                right = mid - 1;
            }
        }

        if (left === 0) {
            minVal = inorder[0];
        } else if (left === inorder.length) {
            maxVal = inorder[inorder.length - 1];
        } else {
            minVal = inorder[left - 1];
            maxVal = inorder[left];
        }

        result.push([minVal, maxVal]);
    }

    return result;
}