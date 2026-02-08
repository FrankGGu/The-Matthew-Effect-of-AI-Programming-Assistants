function maximumLength(s, k) {
    const n = s.length;
    let dp = Array(26).fill(0);
    let maxLen = 0;

    for (let i = 0; i < n; i++) {
        const c = s[i];
        const idx = c.charCodeAt(0) - 'a'.charCodeAt(0);
        const newDp = [...dp];
        for (let j = 0; j < 26; j++) {
            if (j === idx) {
                newDp[j] = Math.max(newDp[j], dp[j] + 1);
            } else {
                newDp[j] = Math.max(newDp[j], dp[j]);
            }
        }
        for (let j = 0; j < 26; j++) {
            if (j !== idx) {
                newDp[j] = Math.max(newDp[j], dp[j] + (k > 0 ? 1 : 0));
            }
        }
        dp = newDp;
        maxLen = Math.max(maxLen, dp[idx]);
    }

    return maxLen;
}