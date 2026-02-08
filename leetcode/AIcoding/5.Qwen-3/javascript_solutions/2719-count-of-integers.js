function countOfIntegers(num, limit, goal) {
    const MOD = 10 ** 9 + 7;
    const dp = Array.from({ length: num + 1 }, () => Array(limit + 1).fill(0));
    dp[0][0] = 1;

    for (let i = 1; i <= num; i++) {
        for (let j = 0; j <= limit; j++) {
            for (let k = 0; k <= 9; k++) {
                if (j - k >= 0) {
                    dp[i][j] = (dp[i][j] + dp[i - 1][j - k]) % MOD;
                }
            }
        }
    }

    return dp[num][goal];
}