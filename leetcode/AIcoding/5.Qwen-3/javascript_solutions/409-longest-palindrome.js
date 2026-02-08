function longestPalindrome(s) {
    const count = {};
    for (const char of s) {
        count[char] = (count[char] || 0) + 1;
    }
    let length = 0;
    let hasOdd = false;
    for (const key in count) {
        if (count[key] % 2 === 0) {
            length += count[key];
        } else {
            length += count[key] - 1;
            hasOdd = true;
        }
    }
    return hasOdd ? length + 1 : length;
}