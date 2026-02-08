function minOperations(nums) {
    const n = nums.length;
    let dp = new Array(n + 1).fill(0);
    for (let i = 1; i <= n; i++) {
        dp[i] = dp[i - 1] + (nums[i - 1] !== 1 ? 1 : 0);
    }
    for (let i = 2; i <= n; i++) {
        dp[i] = Math.min(dp[i], dp[i - 1] + (nums[i - 1] !== 2 ? 1 : 0));
    }
    for (let i = 3; i <= n; i++) {
        dp[i] = Math.min(dp[i], dp[i - 1] + (nums[i - 1] !== 3 ? 1 : 0));
    }
    return dp[n];
}