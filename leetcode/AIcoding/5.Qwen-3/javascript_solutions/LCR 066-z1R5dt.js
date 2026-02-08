function findAndReplacePattern(words, pattern) {
    function getPattern(word) {
        const map = {};
        return word.split('').map(char => map[char] || (map[char] = Object.keys(map).length + 1)).join('');
    }

    const patternCode = getPattern(pattern);
    const result = [];

    for (const word of words) {
        if (getPattern(word) === patternCode) {
            result.push(word);
        }
    }

    return result;
}