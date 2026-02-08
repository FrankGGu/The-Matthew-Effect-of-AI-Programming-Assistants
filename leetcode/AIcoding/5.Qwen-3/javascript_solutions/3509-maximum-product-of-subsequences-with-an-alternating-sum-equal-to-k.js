function maxProductSubsequence(nums, k) {
    const MOD = 1000000007;
    const n = nums.length;
    const dp = new Array(n + 1).fill(0).map(() => new Array(k + 1).fill(0));

    for (let i = 0; i <= n; i++) {
        dp[i][0] = 1;
    }

    for (let i = 1; i <= n; i++) {
        for (let j = 1; j <= k; j++) {
            dp[i][j] = dp[i - 1][j];
            if (j >= nums[i - 1]) {
                dp[i][j] = Math.max(dp[i][j], dp[i - 1][j - nums[i - 1]] * nums[i - 1]);
            }
        }
    }

    return dp[n][k];
}