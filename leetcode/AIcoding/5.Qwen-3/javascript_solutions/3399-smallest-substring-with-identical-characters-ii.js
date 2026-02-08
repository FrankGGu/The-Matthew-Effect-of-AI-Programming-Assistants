function smallestSubstring(s) {
    let result = '';
    const count = new Map();
    let left = 0;
    let minLen = Infinity;

    for (let right = 0; right < s.length; right++) {
        const char = s[right];
        count.set(char, (count.get(char) || 0) + 1);

        while (count.size === 2) {
            const currentLen = right - left + 1;
            if (currentLen < minLen) {
                minLen = currentLen;
                result = s.substring(left, right + 1);
            }

            const leftChar = s[left];
            count.set(leftChar, count.get(leftChar) - 1);
            if (count.get(leftChar) === 0) {
                count.delete(leftChar);
            }
            left++;
        }
    }

    return result;
}