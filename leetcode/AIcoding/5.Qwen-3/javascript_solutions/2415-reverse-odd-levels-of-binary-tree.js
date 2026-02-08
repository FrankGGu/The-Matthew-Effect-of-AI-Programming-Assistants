function reverseOddLevels(root) {
    if (!root) return null;

    const queue = [root];
    let level = 0;

    while (queue.length > 0) {
        const levelSize = queue.length;
        const levelNodes = [];

        for (let i = 0; i < levelSize; i++) {
            const node = queue.shift();
            levelNodes.push(node);

            if (node.left) queue.push(node.left);
            if (node.right) queue.push(node.right);
        }

        if (level % 2 === 1) {
            for (let i = 0; i < levelNodes.length / 2; i++) {
                const temp = levelNodes[i].val;
                levelNodes[i].val = levelNodes[levelNodes.length - 1 - i].val;
                levelNodes[levelNodes.length - 1 - i].val = temp;
            }
        }

        level++;
    }

    return root;
}