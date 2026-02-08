function toGoatLatin(S) {
    const vowels = new Set(['a', 'e', 'i', 'o', 'u', 'A', 'E', 'I', 'O', 'U']);
    const words = S.split(' ');
    const result = [];

    for (let i = 0; i < words.length; i++) {
        let word = words[i];
        if (vowels.has(word[0])) {
            result.push(word + 'ma');
        } else {
            result.push(word.slice(1) + word[0] + 'ma');
        }
        result[i] += 'a'.repeat(i + 1);
    }

    return result.join(' ');
}