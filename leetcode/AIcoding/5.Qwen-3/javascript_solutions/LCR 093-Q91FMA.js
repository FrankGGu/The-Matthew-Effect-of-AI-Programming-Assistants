function lenLongestFibSubseq(a) {
    let n = a.length;
    let dp = new Array(n).fill(0).map(() => new Array(n).fill(2));
    let maxLen = 2;
    for (let i = 0; i < n; i++) {
        for (let j = i + 1; j < n; j++) {
            let prev = a[j] - a[i];
            for (let k = 0; k < i; k++) {
                if (a[k] === prev) {
                    dp[i][j] = dp[k][i] + 1;
                    maxLen = Math.max(maxLen, dp[i][j]);
                    break;
                }
            }
        }
    }
    return maxLen;
}