function findWords(board, words) {
    const result = [];
    const trie = {};

    // Build trie
    for (const word of words) {
        let node = trie;
        for (const char of word) {
            if (!node[char]) node[char] = {};
            node = node[char];
        }
        node.word = word;
    }

    const directions = [[-1, 0], [1, 0], [0, -1], [0, 1]];

    function dfs(i, j, node) {
        const char = board[i][j];
        if (!node[char]) return;

        node = node[char];
        if (node.word) {
            result.push(node.word);
            node.word = null; // prevent duplicate
        }

        board[i][j] = '#'; // mark as visited
        for (const [dx, dy] of directions) {
            const x = i + dx, y = j + dy;
            if (x >= 0 && y >= 0 && x < board.length && y < board[0].length) {
                dfs(x, y, node);
            }
        }
        board[i][j] = char; // backtrack
    }

    for (let i = 0; i < board.length; i++) {
        for (let j = 0; j < board[0].length; j++) {
            dfs(i, j, trie);
        }
    }

    return result;
}