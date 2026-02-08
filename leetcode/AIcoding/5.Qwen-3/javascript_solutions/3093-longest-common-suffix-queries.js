function longestCommonSuffixQueries(words, queries) {
    const suffixMap = new Map();

    for (const word of words) {
        let suffix = '';
        for (let i = word.length - 1; i >= 0; i--) {
            suffix = word[i] + suffix;
            if (!suffixMap.has(suffix)) {
                suffixMap.set(suffix, 0);
            }
            suffixMap.set(suffix, suffixMap.get(suffix) + 1);
        }
    }

    const result = [];
    for (const query of queries) {
        result.push(suffixMap.get(query) || 0);
    }

    return result;
}