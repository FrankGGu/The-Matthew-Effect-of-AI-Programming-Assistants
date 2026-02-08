function countOfSubstrings(s, k) {
    const vowels = new Set(['a', 'e', 'i', 'o', 'u']);
    let count = 0;
    const freq = Array(26).fill(0);
    let vowelCount = 0;

    for (let i = 0; i < s.length; i++) {
        const c = s[i];
        if (vowels.has(c)) {
            if (freq[c.charCodeAt(0) - 'a'.charCodeAt(0)] === 0) {
                vowelCount++;
            }
            freq[c.charCodeAt(0) - 'a'.charCodeAt(0)]++;
        } else {
            freq[c.charCodeAt(0) - 'a'.charCodeAt(0)]++;
        }

        if (i >= k) {
            const prev = s[i - k];
            if (vowels.has(prev)) {
                freq[prev.charCodeAt(0) - 'a'.charCodeAt(0)]--;
                if (freq[prev.charCodeAt(0) - 'a'.charCodeAt(0)] === 0) {
                    vowelCount--;
                }
            } else {
                freq[prev.charCodeAt(0) - 'a'.charCodeAt(0)]--;
            }
        }

        if (i >= k - 1 && vowelCount === 5) {
            count++;
        }
    }

    return count;
}