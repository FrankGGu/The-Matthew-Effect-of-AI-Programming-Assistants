function countVowelStrings(word) {
    let count = 0;
    const vowels = new Set(['a', 'e', 'i', 'o', 'u']);
    for (let i = 0; i < word.length; i++) {
        if (vowels.has(word[i])) {
            count++;
        }
    }
    return count;
}

function vowelStrings(word, queries) {
    const result = [];
    for (const [l, r] of queries) {
        let count = 0;
        for (let i = l; i <= r; i++) {
            if (word[i] === 'a' || word[i] === 'e' || word[i] === 'i' || word[i] === 'o' || word[i] === 'u') {
                count++;
            }
        }
        result.push(count);
    }
    return result;
}