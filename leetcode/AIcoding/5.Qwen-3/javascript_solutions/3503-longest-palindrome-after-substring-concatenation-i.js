function longestPalindrome(s) {
    const n = s.length;
    let maxLen = 0;

    for (let i = 0; i < n; i++) {
        for (let j = i + 1; j <= n; j++) {
            const substr = s.substring(i, j);
            let left = 0;
            let right = substr.length - 1;
            let isPalindrome = true;
            while (left < right) {
                if (substr[left] !== substr[right]) {
                    isPalindrome = false;
                    break;
                }
                left++;
                right--;
            }
            if (isPalindrome) {
                maxLen = Math.max(maxLen, substr.length);
            }
        }
    }

    return maxLen;
}