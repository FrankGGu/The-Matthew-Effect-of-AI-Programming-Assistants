function countPalindromicSubsequences(s) {
    const n = s.length;
    const dp = Array.from({ length: n }, () => Array(n).fill(0));

    for (let i = 0; i < n; i++) {
        dp[i][i] = 1;
    }

    for (let length = 2; length <= n; length++) {
        for (let i = 0; i <= n - length; i++) {
            let j = i + length - 1;
            if (s[i] === s[j]) {
                if (length === 2) {
                    dp[i][j] = 2 + dp[i + 1][j - 1];
                } else {
                    dp[i][j] = dp[i + 1][j - 1] * 2 + 2;
                }
            } else {
                dp[i][j] = dp[i + 1][j] + dp[i][j - 1] - dp[i + 1][j - 1];
            }
        }
    }

    return dp[0][n - 1];
}