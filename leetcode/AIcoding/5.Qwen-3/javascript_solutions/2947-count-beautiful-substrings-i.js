function countBeautifulSubstrings(word, k) {
    const n = word.length;
    let count = 0;

    for (let i = 0; i < n; i++) {
        let vowels = 0;
        for (let j = i; j < n; j++) {
            if ("aeiou".includes(word[j])) {
                vowels++;
            }
            if (vowels > 0 && (j - i + 1) % k === 0 && vowels % k === 0) {
                count++;
            }
        }
    }

    return count;
}