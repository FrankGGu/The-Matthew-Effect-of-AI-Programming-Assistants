function spellchecker(wordList, queries) {
    const vowels = new Set(['a', 'e', 'i', 'o', 'u']);
    const caseMap = new Map();
    const vowelMap = new Map();

    for (const word of wordList) {
        const lowerWord = word.toLowerCase();
        const vowelWord = lowerWord.replace(/[aeiou]/g, '*');

        if (!caseMap.has(lowerWord)) {
            caseMap.set(lowerWord, word);
        }

        if (!vowelMap.has(vowelWord)) {
            vowelMap.set(vowelWord, word);
        }
    }

    const result = [];

    for (const query of queries) {
        const lowerQuery = query.toLowerCase();
        const vowelQuery = lowerQuery.replace(/[aeiou]/g, '*');

        if (caseMap.has(lowerQuery)) {
            result.push(caseMap.get(lowerQuery));
        } else if (vowelMap.has(vowelQuery)) {
            result.push(vowelMap.get(vowelQuery));
        } else {
            result.push("");
        }
    }

    return result;
}