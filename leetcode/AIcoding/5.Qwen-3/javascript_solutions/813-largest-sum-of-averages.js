var largestSumOfAverages = function(nums, k) {
    const n = nums.length;
    const dp = new Array(n).fill(0).map(() => new Array(k + 1).fill(0));
    const prefix = new Array(n + 1).fill(0);

    for (let i = 0; i < n; ++i) {
        prefix[i + 1] = prefix[i] + nums[i];
    }

    for (let i = 0; i < n; ++i) {
        dp[i][1] = prefix[n] - prefix[i];
    }

    for (let j = 2; j <= k; ++j) {
        for (let i = 0; i < n; ++i) {
            for (let m = i; m < n; ++m) {
                if (m + 1 <= n) {
                    dp[i][j] = Math.max(dp[i][j], dp[m + 1][j - 1] + (prefix[m + 1] - prefix[i]));
                }
            }
        }
    }

    return dp[0][k];
};