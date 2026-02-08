function longestBalancedSubstring(s) {
    let maxLen = 0;
    let count = 0;
    let zeroCount = 0;
    let oneCount = 0;

    for (let i = 0; i < s.length; i++) {
        if (s[i] === '0') {
            zeroCount++;
        } else {
            oneCount++;
        }

        if (zeroCount === oneCount) {
            maxLen = Math.max(maxLen, zeroCount + oneCount);
        } else if (zeroCount > oneCount) {
            zeroCount = 0;
            oneCount = 0;
        }
    }

    return maxLen;
}