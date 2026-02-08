var getMoneyAmount = function(n) {
    const dp = Array.from({ length: n + 1 }, () => Array(n + 1).fill(0));

    for (let length = 2; length <= n; length++) {
        for (let i = 1; i <= n - length; i++) {
            let j = i + length;
            dp[i][j] = Infinity;
            for (let k = i; k <= j; k++) {
                const cost = k + Math.max(dp[i][k - 1], dp[k + 1][j]);
                dp[i][j] = Math.min(dp[i][j], cost);
            }
        }
    }

    return dp[1][n];
};