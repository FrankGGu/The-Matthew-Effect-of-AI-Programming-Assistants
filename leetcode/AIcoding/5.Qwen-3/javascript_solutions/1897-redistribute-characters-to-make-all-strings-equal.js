function areAlmostEqual(word1, word2) {
    if (word1.length !== word2.length) return false;
    const diff = [];
    for (let i = 0; i < word1.length; i++) {
        if (word1[i] !== word2[i]) {
            diff.push(i);
            if (diff.length > 2) return false;
        }
    }
    return diff.length === 0 || (diff.length === 2 && word1[diff[0]] === word2[diff[1]] && word1[diff[1]] === word2[diff[0]]);
}