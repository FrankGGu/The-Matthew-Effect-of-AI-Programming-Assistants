function frequencySort(s) {
    const freq = {};
    for (const char of s) {
        freq[char] = (freq[char] || 0) + 1;
    }

    const sortedChars = Object.keys(freq).sort((a, b) => freq[b] - freq[a]);

    let result = '';
    for (const char of sortedChars) {
        result += char.repeat(freq[char]);
    }

    return result;
}