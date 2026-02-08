function countSubstrings(s) {
    let count = 0;
    for (let i = 0; i < s.length; i++) {
        for (let j = i + 1; j <= s.length; j++) {
            const substr = s.substring(i, j);
            const lastDigit = parseInt(substr.slice(-1));
            if (lastDigit !== 0 && parseInt(substr) % lastDigit === 0) {
                count++;
            }
        }
    }
    return count;
}