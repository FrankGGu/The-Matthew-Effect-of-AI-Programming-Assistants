function uncommonFromSentences(s1, s2) {
    const wordCount = {};

    function countWords(sentence) {
        const words = sentence.split(' ');
        for (const word of words) {
            wordCount[word] = (wordCount[word] || 0) + 1;
        }
    }

    countWords(s1);
    countWords(s2);

    const result = [];
    for (const word in wordCount) {
        if (wordCount[word] === 1) {
            result.push(word);
        }
    }

    return result;
}