function sumDistance(nums, n) {
    const MOD = 10 ** 9 + 7;
    const m = nums.length;
    const dp = new Array(n + 1).fill(0).map(() => new Array(m).fill(0));
    for (let i = 0; i < m; i++) {
        dp[1][i] = 0;
    }
    for (let k = 2; k <= n; k++) {
        for (let i = 0; i < m; i++) {
            for (let j = 0; j < m; j++) {
                if (i !== j) {
                    dp[k][i] += Math.abs(nums[i] - nums[j]) + dp[k - 1][j];
                    dp[k][i] %= MOD;
                }
            }
        }
    }
    let result = 0;
    for (let i = 0; i < m; i++) {
        result = (result + dp[n][i]) % MOD;
    }
    return result;
}