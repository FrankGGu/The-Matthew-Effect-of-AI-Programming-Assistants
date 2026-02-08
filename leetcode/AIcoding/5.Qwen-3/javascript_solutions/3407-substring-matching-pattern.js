function checkIfPangram(sentence) {
    const seen = new Set();
    for (const char of sentence.toLowerCase()) {
        if (char >= 'a' && char <= 'z') {
            seen.add(char);
        }
    }
    return seen.size === 26;
}