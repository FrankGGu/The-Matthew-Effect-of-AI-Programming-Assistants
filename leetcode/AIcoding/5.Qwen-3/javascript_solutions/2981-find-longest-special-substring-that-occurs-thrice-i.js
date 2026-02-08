function longestSpecialSubstring(s) {
    const count = new Map();

    for (let i = 0; i < s.length; i++) {
        let j = i;
        while (j < s.length && s[j] === s[i]) j++;
        const len = j - i;
        for (let k = 1; k <= len; k++) {
            const key = s[i] + String(k);
            count.set(key, (count.get(key) || 0) + 1);
        }
        i = j - 1;
    }

    let result = -1;
    for (const [key, freq] of count.entries()) {
        if (freq >= 3) {
            const length = parseInt(key.slice(1));
            result = Math.max(result, length);
        }
    }

    return result;
}