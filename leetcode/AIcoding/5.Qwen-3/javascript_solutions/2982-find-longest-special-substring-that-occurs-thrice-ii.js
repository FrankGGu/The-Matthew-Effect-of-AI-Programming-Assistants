function longestSpecialSubstring(s) {
    const n = s.length;
    const freq = new Map();

    for (let i = 0; i < n; i++) {
        let j = i;
        while (j < n && s[j] === s[i]) {
            j++;
        }
        const len = j - i;
        for (let k = 1; k <= len; k++) {
            const key = s[i] + String(k);
            freq.set(key, (freq.get(key) || 0) + 1);
        }
        i = j - 1;
    }

    let result = -1;
    for (const [key, count] of freq.entries()) {
        if (count >= 3) {
            const length = parseInt(key.slice(1));
            result = Math.max(result, length);
        }
    }

    return result;
}