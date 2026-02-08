function minWindow(s, t) {
    if (s.length < t.length || t.length === 0) return "";
    const charCount = {};
    for (let char of t) {
        charCount[char] = (charCount[char] || 0) + 1;
    }
    let required = Object.keys(charCount).length;
    let formed = 0;
    let left = 0, right = 0;
    let windowCount = {};
    let result = [Infinity, 0, 0];

    while (right < s.length) {
        let char = s[right];
        windowCount[char] = (windowCount[char] || 0) + 1;

        if (charCount[char] && windowCount[char] === charCount[char]) {
            formed++;
        }

        while (formed === required) {
            if (right - left + 1 < result[0]) {
                result = [right - left + 1, left, right];
            }

            char = s[left];
            windowCount[char]--;
            if (charCount[char] && windowCount[char] < charCount[char]) {
                formed--;
            }
            left++;
        }

        right++;
    }

    return result[0] === Infinity ? "" : s.substring(result[1], result[2] + 1);
}