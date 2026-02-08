function longestAlphabeticalSubstring(s) {
    if (s.length === 0) return 0;

    let maxLength = 1;
    let currentLength = 1;

    for (let i = 1; i < s.length; i++) {
        if (s[i].charCodeAt(0) === s[i - 1].charCodeAt(0) + 1) {
            currentLength++;
            maxLength = Math.max(maxLength, currentLength);
        } else {
            currentLength = 1;
        }
    }

    return maxLength;
}