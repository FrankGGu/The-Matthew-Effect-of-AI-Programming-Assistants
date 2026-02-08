function findTargetSumWays(nums, target) {
    const sum = nums.reduce((a, b) => a + b, 0);
    if (Math.abs(target) > sum || (sum + target) % 2 !== 0) return 0;
    const n = (sum + target) / 2;
    const dp = Array(n + 1).fill(0);
    dp[0] = 1;
    for (const num of nums) {
        for (let i = n; i >= num; i--) {
            dp[i] += dp[i - num];
        }
    }
    return dp[n];
}