function findSubstring(s, words) {
    if (words.length === 0) return [];
    const wordLen = words[0].length;
    const totalWords = words.length;
    const result = [];
    const wordCount = {};

    for (const word of words) {
        wordCount[word] = (wordCount[word] || 0) + 1;
    }

    for (let i = 0; i < s.length - wordLen * totalWords + 1; i++) {
        const seen = {};
        let match = true;

        for (let j = 0; j < totalWords; j++) {
            const currentWord = s.substring(i + j * wordLen, i + (j + 1) * wordLen);
            if (!wordCount[currentWord]) {
                match = false;
                break;
            }
            seen[currentWord] = (seen[currentWord] || 0) + 1;
            if (seen[currentWord] > wordCount[currentWord]) {
                match = false;
                break;
            }
        }

        if (match) {
            result.push(i);
        }
    }

    return result;
}