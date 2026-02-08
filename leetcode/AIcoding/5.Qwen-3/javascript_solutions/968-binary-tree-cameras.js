function TreeNode(val) {
    this.val = val;
    this.left = null;
    this.right = null;
}

var minCameraCover = function(root) {
    let count = 0;

    const dfs = (node) => {
        if (!node) return 0;

        const left = dfs(node.left);
        const right = dfs(node.right);

        if (left === 0 || right === 0) {
            count++;
            return 1;
        } else if (left === 1 || right === 1) {
            return 2;
        } else {
            return 0;
        }
    };

    if (dfs(root) === 0) {
        count++;
    }

    return count;
};