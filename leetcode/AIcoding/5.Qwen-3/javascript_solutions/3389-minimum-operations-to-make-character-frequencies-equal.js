function minOperations(s) {
    const freq = {};
    for (const c of s) {
        freq[c] = (freq[c] || 0) + 1;
    }

    const counts = Object.values(freq);
    const total = s.length;

    for (let i = 1; i <= total; i++) {
        let required = 0;
        for (const count of counts) {
            if (count > i) {
                required += count - i;
            }
        }
        if (required === 0) return 0;
        if (required <= total - i * counts.length) {
            return required;
        }
    }

    return -1;
}