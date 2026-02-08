function minCostToRemoveArrayElements(nums) {
    const n = nums.length;
    const dp = new Array(n).fill(0);
    for (let i = 1; i < n; i++) {
        dp[i] = dp[i - 1];
        if (nums[i] === nums[i - 1]) {
            dp[i]++;
        } else {
            dp[i] += 1;
        }
    }
    return dp[n - 1];
}