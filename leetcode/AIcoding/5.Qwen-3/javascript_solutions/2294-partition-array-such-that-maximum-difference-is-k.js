function canPartitionK(nums, k) {
    nums.sort((a, b) => a - b);
    const n = nums.length;
    const dp = new Array(n).fill(false);
    dp[0] = true;
    for (let i = 1; i < n; i++) {
        for (let j = 0; j < i; j++) {
            if (dp[j] && nums[i] - nums[j] <= k) {
                dp[i] = true;
                break;
            }
        }
    }
    return dp[n - 1];
}