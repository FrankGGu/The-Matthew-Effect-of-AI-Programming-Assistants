function replaceWords(dict, sentence) {
    const root = {};
    for (const word of dict) {
        let node = root;
        for (const c of word) {
            if (!node[c]) node[c] = {};
            node = node[c];
        }
        node.isEnd = true;
    }

    function getShortestRoot(word) {
        let node = root;
        let prefix = '';
        for (const c of word) {
            if (node.isEnd) return prefix;
            if (!node[c]) return '';
            node = node[c];
            prefix += c;
        }
        return '';
    }

    return sentence.split(' ').map(word => {
        const replacement = getShortestRoot(word);
        return replacement ? replacement : word;
    }).join(' ');
}