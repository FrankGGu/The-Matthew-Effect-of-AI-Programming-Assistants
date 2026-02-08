function mostFrequentVowelAndConsonant(s) {
    const vowels = new Set(['a', 'e', 'i', 'o', 'u']);
    const vowelCount = {};
    const consonantCount = {};
    let maxVowel = '';
    let maxConsonant = '';
    let maxVowelCount = 0;
    let maxConsonantCount = 0;

    for (const char of s.toLowerCase()) {
        if (vowels.has(char)) {
            vowelCount[char] = (vowelCount[char] || 0) + 1;
            if (vowelCount[char] > maxVowelCount) {
                maxVowelCount = vowelCount[char];
                maxVowel = char;
            }
        } else if (char >= 'a' && char <= 'z') {
            consonantCount[char] = (consonantCount[char] || 0) + 1;
            if (consonantCount[char] > maxConsonantCount) {
                maxConsonantCount = consonantCount[char];
                maxConsonant = char;
            }
        }
    }

    return maxVowel + maxConsonant;
}