function minOperations(word, k) {
    const n = word.length;
    const freq = {};
    for (let i = 0; i < n; i += k) {
        const sub = word.substring(i, i + k);
        freq[sub] = (freq[sub] || 0) + 1;
    }

    let maxFreq = 0;
    for (const count of Object.values(freq)) {
        maxFreq = Math.max(maxFreq, count);
    }

    return n / k - maxFreq;
}