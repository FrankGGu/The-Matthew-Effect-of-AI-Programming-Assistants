function minimumLengthEncoding(words) {
    const set = new Set(words);
    for (const word of words) {
        for (let i = 1; i < word.length; i++) {
            set.delete(word.substring(i));
        }
    }
    let result = 0;
    for (const word of set) {
        result += word.length + 1;
    }
    return result;
}