function generateTrees(n) {
    function generate(start, end) {
        if (start > end) return [null];
        const result = [];
        for (let i = start; i <= end; i++) {
            const leftSubtrees = generate(start, i - 1);
            const rightSubtrees = generate(i + 1, end);
            for (let left of leftSubtrees) {
                for (let right of rightSubtrees) {
                    const root = new TreeNode(i);
                    root.left = left;
                    root.right = right;
                    result.push(root);
                }
            }
        }
        return result;
    }
    return generate(1, n);
}

function TreeNode(val) {
    this.val = val;
    this.left = null;
    this.right = null;
}