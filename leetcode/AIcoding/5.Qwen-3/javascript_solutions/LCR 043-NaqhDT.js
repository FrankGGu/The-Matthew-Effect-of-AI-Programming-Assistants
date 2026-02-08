var CBTInserter = function(root) {
    this.root = root;
    this.queue = [];
    let levelQueue = [root];
    while (levelQueue.length > 0) {
        let node = levelQueue.shift();
        if (node.left) levelQueue.push(node.left);
        if (node.right) levelQueue.push(node.right);
        if (!node.left || !node.right) this.queue.push(node);
    }
};

CBTInserter.prototype.insert = function(v) {
    let node = this.queue[0];
    let newNode = new TreeNode(v);
    if (!node.left) {
        node.left = newNode;
    } else {
        node.right = newNode;
        this.queue.shift();
    }
    this.queue.push(newNode);
    return newNode;
};

CBTInserter.prototype.get_root = function() {
    return this.root;
};