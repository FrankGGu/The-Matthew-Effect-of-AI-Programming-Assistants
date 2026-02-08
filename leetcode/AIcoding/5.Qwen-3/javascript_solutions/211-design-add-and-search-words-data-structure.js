var WordDictionary = function() {
    this.root = {};
};

WordDictionary.prototype.addWord = function(word) {
    let node = this.root;
    for (let i = 0; i < word.length; i++) {
        const c = word[i];
        if (!node[c]) {
            node[c] = {};
        }
        node = node[c];
    }
    node.isEnd = true;
};

WordDictionary.prototype.search = function(word) {
    const dfs = (node, index) => {
        if (index === word.length) {
            return node.isEnd === true;
        }
        const c = word[index];
        if (c === '.') {
            for (const key in node) {
                if (key !== 'isEnd' && dfs(node[key], index + 1)) {
                    return true;
                }
            }
            return false;
        } else {
            if (!node[c]) {
                return false;
            }
            return dfs(node[c], index + 1);
        }
    };
    return dfs(this.root, 0);
};