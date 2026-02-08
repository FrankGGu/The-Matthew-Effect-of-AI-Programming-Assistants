function twoEditWords(words, dictionary) {
    const result = [];
    for (const word of words) {
        let diff = 0;
        for (let i = 0; i < Math.min(word.length, dictionary.length); i++) {
            if (word[i] !== dictionary[i]) {
                diff++;
                if (diff > 2) break;
            }
        }
        if (diff <= 2) {
            result.push(word);
        }
    }
    return result;
}