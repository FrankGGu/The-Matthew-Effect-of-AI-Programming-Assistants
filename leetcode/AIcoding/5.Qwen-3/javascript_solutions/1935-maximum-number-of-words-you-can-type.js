function canBeTypedWords(text, brokenLetters) {
    const words = text.split(' ');
    let count = 0;
    for (const word of words) {
        let valid = true;
        for (const ch of brokenLetters) {
            if (word.includes(ch)) {
                valid = false;
                break;
            }
        }
        if (valid) count++;
    }
    return count;
}