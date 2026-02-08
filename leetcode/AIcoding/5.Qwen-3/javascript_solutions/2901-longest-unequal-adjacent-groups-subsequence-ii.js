function longestSubsequence(n, s, a) {
    const dp = new Array(n).fill(0);
    const prev = new Array(n).fill(-1);
    const last = new Array(26).fill(-1);

    for (let i = 0; i < n; i++) {
        const c = s[i].charCodeAt(0) - 'a'.charCodeAt(0);
        let maxLen = 0;
        let idx = -1;
        for (let j = 0; j < 26; j++) {
            if (last[j] !== -1 && a[last[j]] < a[i]) {
                if (dp[last[j]] > maxLen) {
                    maxLen = dp[last[j]];
                    idx = last[j];
                }
            }
        }
        dp[i] = maxLen + 1;
        prev[i] = idx;
        last[c] = i;
    }

    let maxIndex = 0;
    for (let i = 1; i < n; i++) {
        if (dp[i] > dp[maxIndex]) {
            maxIndex = i;
        }
    }

    const result = [];
    let current = maxIndex;
    while (current !== -1) {
        result.unshift(current);
        current = prev[current];
    }

    return result;
}