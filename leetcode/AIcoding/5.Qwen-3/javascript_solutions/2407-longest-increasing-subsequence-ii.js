function lengthOfLIS(nums) {
    const dp = [];
    for (let i = 0; i < nums.length; i++) {
        let max = 0;
        for (let j = 0; j < i; j++) {
            if (nums[j] < nums[i]) {
                max = Math.max(max, dp[j]);
            }
        }
        dp[i] = max + 1;
    }
    return Math.max(...dp);
}