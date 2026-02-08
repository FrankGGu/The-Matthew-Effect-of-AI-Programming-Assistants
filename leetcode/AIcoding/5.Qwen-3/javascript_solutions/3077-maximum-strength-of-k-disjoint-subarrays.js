function maxStrength(nums, k) {
    const n = nums.length;
    const dp = Array.from({ length: k + 1 }, () => Array(n).fill(-Infinity));
    const prev = Array.from({ length: k + 1 }, () => Array(n).fill(-Infinity));

    for (let i = 0; i < n; i++) {
        dp[1][i] = nums[i];
        prev[1][i] = nums[i];
    }

    for (let t = 2; t <= k; t++) {
        for (let i = t - 1; i < n; i++) {
            dp[t][i] = Math.max(dp[t][i - 1], prev[t - 1][i - 1] + nums[i]);
            prev[t][i] = Math.max(prev[t][i - 1], dp[t][i]);
        }
    }

    return dp[k][n - 1];
}