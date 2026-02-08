function countVowels(s) {
    const vowels = new Set(['a', 'e', 'i', 'o', 'u']);
    let count = 0;
    for (let i = 0; i < s.length; i++) {
        if (vowels.has(s[i])) {
            count += (i + 1) * (s.length - i);
        }
    }
    return count;
}