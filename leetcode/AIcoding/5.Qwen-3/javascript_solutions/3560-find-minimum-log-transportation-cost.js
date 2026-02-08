function minCostToConvert(nums, cost) {
    const n = nums.length;
    const dp = new Array(n).fill(0).map(() => new Array(n).fill(0));

    for (let l = 2; l <= n; l++) {
        for (let i = 0; i <= n - l; i++) {
            let j = i + l - 1;
            dp[i][j] = Infinity;
            for (let k = i; k < j; k++) {
                dp[i][j] = Math.min(dp[i][j], dp[i][k] + dp[k + 1][j] + cost[i] * (nums[k] - nums[i]) + cost[j] * (nums[j] - nums[k + 1]));
            }
        }
    }

    return dp[0][n - 1];
}