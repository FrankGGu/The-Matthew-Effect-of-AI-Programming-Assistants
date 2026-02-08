function verifyPostorder(postorder) {
    const stack = [];
    let root = Infinity;
    for (const node of postorder) {
        if (node > root) return false;
        while (stack.length && node > stack[stack.length - 1]) {
            root = stack.pop();
        }
        stack.push(node);
    }
    return true;
}