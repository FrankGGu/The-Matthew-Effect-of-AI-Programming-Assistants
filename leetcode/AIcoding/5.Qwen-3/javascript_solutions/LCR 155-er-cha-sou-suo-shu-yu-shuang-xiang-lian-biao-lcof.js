function treeToDoublyList(root) {
    if (!root) return null;

    let prev = null;
    let head = null;

    function dfs(node) {
        if (!node) return;

        dfs(node.left);

        if (prev) {
            prev.right = node;
            node.left = prev;
        } else {
            head = node;
        }

        prev = node;

        dfs(node.right);
    }

    dfs(root);

    if (head) {
        head.left = prev;
        prev.right = head;
    }

    return head;
}