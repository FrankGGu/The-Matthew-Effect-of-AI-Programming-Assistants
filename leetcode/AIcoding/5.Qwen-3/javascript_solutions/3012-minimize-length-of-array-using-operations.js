function minLengthAfterRemovals(s) {
    const n = s.length;
    const freq = {};
    for (let c of s) {
        freq[c] = (freq[c] || 0) + 1;
    }

    let maxFreq = 0;
    for (let key in freq) {
        if (freq[key] > maxFreq) {
            maxFreq = freq[key];
        }
    }

    return Math.max(0, 2 * maxFreq - n);
}