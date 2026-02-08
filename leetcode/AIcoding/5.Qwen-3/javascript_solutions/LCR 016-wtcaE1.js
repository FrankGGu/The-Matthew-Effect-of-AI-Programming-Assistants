function lengthOfLongestSubstring(s) {
    let left = 0;
    let maxLength = 0;
    const charMap = {};

    for (let right = 0; right < s.length; right++) {
        const char = s[right];
        if (char in charMap && charMap[char] >= left) {
            left = charMap[char] + 1;
        }
        charMap[char] = right;
        maxLength = Math.max(maxLength, right - left + 1);
    }

    return maxLength;
}