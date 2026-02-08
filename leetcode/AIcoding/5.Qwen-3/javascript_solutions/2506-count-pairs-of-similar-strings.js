function similarPairs(words) {
    const map = new Map();
    let count = 0;

    for (const word of words) {
        const key = Array.from(new Set(word)).sort().join('');
        if (map.has(key)) {
            count += map.get(key);
            map.set(key, map.get(key) + 1);
        } else {
            map.set(key, 1);
        }
    }

    return count;
}