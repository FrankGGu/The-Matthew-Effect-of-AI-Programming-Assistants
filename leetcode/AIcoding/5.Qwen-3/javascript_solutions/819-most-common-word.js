function mostCommonWord(paragraph, banned) {
    const words = paragraph.toLowerCase().split(/[^a-z]+/);
    const wordCount = {};
    let maxCount = 0;
    let mostCommon = "";

    for (const word of words) {
        if (word && !banned.includes(word)) {
            wordCount[word] = (wordCount[word] || 0) + 1;
            if (wordCount[word] > maxCount) {
                maxCount = wordCount[word];
                mostCommon = word;
            }
        }
    }

    return mostCommon;
}