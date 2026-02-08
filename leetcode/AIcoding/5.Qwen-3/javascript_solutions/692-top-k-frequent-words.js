function topKFrequent(words, k) {
    const freq = {};
    for (const word of words) {
        freq[word] = (freq[word] || 0) + 1;
    }

    const sorted = Object.keys(freq).sort((a, b) => {
        if (freq[b] !== freq[a]) {
            return freq[b] - freq[a];
        }
        return a.localeCompare(b);
    });

    return sorted.slice(0, k);
}