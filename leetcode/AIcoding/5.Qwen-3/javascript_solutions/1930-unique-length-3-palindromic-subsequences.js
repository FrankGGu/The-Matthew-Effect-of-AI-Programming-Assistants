function uniqueLength3PalindromicSubsequences(s) {
    const count = new Map();
    for (let i = 0; i < s.length; i++) {
        count.set(s[i], (count.get(s[i]) || 0) + 1);
    }

    const result = new Set();

    for (let i = 1; i < s.length - 1; i++) {
        const left = s[i - 1];
        const right = s[i + 1];
        if (count.has(left) && count.has(right)) {
            result.add(left + s[i] + right);
        }
    }

    return result.size;
}