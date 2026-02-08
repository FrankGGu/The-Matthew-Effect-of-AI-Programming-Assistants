function deleteDuplicateFolders(root) {
    const map = new Map();
    const result = [];

    function serialize(node) {
        if (!node) return "";
        const children = [];
        for (const child of node.children) {
            const s = serialize(child);
            if (s) children.push(s);
        }
        const key = children.join(",");
        if (map.has(key)) {
            map.get(key).push(node);
        } else {
            map.set(key, [node]);
        }
        return key;
    }

    serialize(root);

    for (const [key, nodes] of map.entries()) {
        if (nodes.length > 1) {
            for (const node of nodes) {
                result.push(node);
            }
        }
    }

    for (const node of result) {
        const parent = node.parent;
        if (parent) {
            const index = parent.children.indexOf(node);
            if (index !== -1) {
                parent.children.splice(index, 1);
            }
        }
    }

    return root;
}