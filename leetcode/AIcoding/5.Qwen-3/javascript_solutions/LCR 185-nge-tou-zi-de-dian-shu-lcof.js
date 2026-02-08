function dicesProbability(n) {
    const dp = new Array(n + 1).fill(0).map(() => new Array(6 * n + 1).fill(0));
    for (let i = 1; i <= 6; i++) {
        dp[1][i] = 1;
    }
    for (let i = 2; i <= n; i++) {
        for (let j = i; j <= 6 * i; j++) {
            for (let k = 1; k <= 6; k++) {
                if (j - k >= 0) {
                    dp[i][j] += dp[i - 1][j - k];
                }
            }
        }
    }
    const total = Math.pow(6, n);
    const result = [];
    for (let i = n; i <= 6 * n; i++) {
        result.push(dp[n][i] / total);
    }
    return result;
}