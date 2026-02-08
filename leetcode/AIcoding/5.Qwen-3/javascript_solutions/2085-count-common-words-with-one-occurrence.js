function countCommonWordsWithOneOccurrence(words1, words2) {
    const count = (arr) => {
        const map = new Map();
        for (const word of arr) {
            map.set(word, (map.get(word) || 0) + 1);
        }
        return map;
    };

    const map1 = count(words1);
    const map2 = count(words2);

    let result = 0;

    for (const [word, freq] of map1) {
        if (freq === 1 && map2.has(word) && map2.get(word) === 1) {
            result++;
        }
    }

    return result;
}