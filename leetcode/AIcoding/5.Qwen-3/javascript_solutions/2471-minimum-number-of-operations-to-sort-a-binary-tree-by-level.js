var minimumOperations = function(root) {
    const levels = [];
    const queue = [root];

    while (queue.length > 0) {
        const levelSize = queue.length;
        const level = [];

        for (let i = 0; i < levelSize; i++) {
            const node = queue.shift();
            level.push(node.val);

            if (node.left) queue.push(node.left);
            if (node.right) queue.push(node.right);
        }

        levels.push(level);
    }

    let operations = 0;

    for (const level of levels) {
        const sorted = [...level].sort((a, b) => a - b);
        const map = new Map();

        for (let i = 0; i < level.length; i++) {
            map.set(level[i], i);
        }

        for (let i = 0; i < level.length; i++) {
            if (level[i] !== sorted[i]) {
                const j = map.get(sorted[i]);
                [level[i], level[j]] = [level[j], level[i]];
                map.set(level[i], i);
                map.set(level[j], j);
                operations++;
            }
        }
    }

    return operations;
};