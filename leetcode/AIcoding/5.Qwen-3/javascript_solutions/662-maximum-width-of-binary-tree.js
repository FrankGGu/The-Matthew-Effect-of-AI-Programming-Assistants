function TreeNode(val) {
    this.val = val;
    this.left = this.right = null;
}

var widthOfBinaryTree = function(root) {
    if (!root) return 0;

    let maxWidth = 0;
    let queue = [[root, 0]];

    while (queue.length) {
        let levelSize = queue.length;
        let levelStart = queue[0][1];
        let levelEnd = 0;

        for (let i = 0; i < levelSize; i++) {
            let [node, index] = queue.shift();
            levelEnd = index;

            if (node.left) {
                queue.push([node.left, index * 2]);
            }
            if (node.right) {
                queue.push([node.right, index * 2 + 1]);
            }
        }

        maxWidth = Math.max(maxWidth, levelEnd - levelStart + 1);
    }

    return maxWidth;
};