function areOccurrencesEqual(s) {
    const count = {};
    for (const char of s) {
        count[char] = (count[char] || 0) + 1;
    }
    const values = Object.values(count);
    const first = values[0];
    for (let i = 1; i < values.length; i++) {
        if (values[i] !== first) {
            return false;
        }
    }
    return true;
}