function findDuplicateSubtrees(root) {
    const map = new Map();
    const result = [];

    function serialize(node) {
        if (!node) return '#';
        const key = `${node.val},${serialize(node.left)},${serialize(node.right)}`;
        if (map.has(key)) {
            if (map.get(key) === 1) {
                result.push(node);
            }
            map.set(key, map.get(key) + 1);
        } else {
            map.set(key, 1);
        }
        return key;
    }

    serialize(root);
    return result;
}