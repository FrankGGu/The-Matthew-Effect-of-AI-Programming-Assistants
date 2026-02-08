function minCost(nums, k) {
    const n = nums.length;
    const dp = new Array(n + 1).fill(0);

    for (let i = 1; i <= n; i++) {
        let max = nums[i - 1];
        let cost = 0;
        for (let j = i - 1; j >= Math.max(0, i - k); j--) {
            max = Math.max(max, nums[j]);
            cost += max;
            dp[i] = Math.min(dp[i], dp[j] + cost);
        }
    }

    return dp[n];
}