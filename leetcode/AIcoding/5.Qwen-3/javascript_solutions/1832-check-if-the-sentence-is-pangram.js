function checkIfPangram(sentence) {
    const requiredChars = new Set("abcdefghijklmnopqrstuvwxyz");
    const actualChars = new Set(sentence.toLowerCase());
    return requiredChars.size === [...requiredChars].every(c => actualChars.has(c));
}