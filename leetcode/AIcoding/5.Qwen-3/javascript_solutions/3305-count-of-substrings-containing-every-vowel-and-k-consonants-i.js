function countOfSubstrings(s, k) {
    const vowels = new Set(['a', 'e', 'i', 'o', 'u']);
    let count = 0;
    const freq = new Array(26).fill(0);
    let vowelCount = 0;

    for (let i = 0; i < s.length; i++) {
        const c = s[i];
        if (vowels.has(c)) {
            freq[c.charCodeAt(0) - 'a'.charCodeAt(0)]++;
            if (freq[c.charCodeAt(0) - 'a'.charCodeAt(0)] === 1) {
                vowelCount++;
            }
        } else {
            freq[c.charCodeAt(0) - 'a'.charCodeAt(0)]++;
        }

        if (i >= k) {
            const prevChar = s[i - k];
            if (vowels.has(prevChar)) {
                freq[prevChar.charCodeAt(0) - 'a'.charCodeAt(0)]--;
                if (freq[prevChar.charCodeAt(0) - 'a'.charCodeAt(0)] === 0) {
                    vowelCount--;
                }
            } else {
                freq[prevChar.charCodeAt(0) - 'a'.charCodeAt(0)]--;
            }
        }

        if (i >= k - 1 && vowelCount === 5) {
            count++;
        }
    }

    return count;
}