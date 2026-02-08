function TreeNode(val) {
    this.val = val;
    this.left = this.right = null;
}

function distanceK(root, target, k) {
    const result = [];
    const parentMap = new Map();

    function dfs(node) {
        if (!node) return;
        if (node.left) {
            parentMap.set(node.left, node);
            dfs(node.left);
        }
        if (node.right) {
            parentMap.set(node.right, node);
            dfs(node.right);
        }
    }

    dfs(root);

    const visited = new Set();
    const queue = [target];
    visited.add(target);

    while (queue.length > 0) {
        const size = queue.length;
        for (let i = 0; i < size; i++) {
            const node = queue.shift();
            if (k === 0) {
                result.push(node.val);
                continue;
            }
            if (node.left && !visited.has(node.left)) {
                visited.add(node.left);
                queue.push(node.left);
            }
            if (node.right && !visited.has(node.right)) {
                visited.add(node.right);
                queue.push(node.right);
            }
            const parent = parentMap.get(node);
            if (parent && !visited.has(parent)) {
                visited.add(parent);
                queue.push(parent);
            }
        }
        k--;
    }

    return result;
}