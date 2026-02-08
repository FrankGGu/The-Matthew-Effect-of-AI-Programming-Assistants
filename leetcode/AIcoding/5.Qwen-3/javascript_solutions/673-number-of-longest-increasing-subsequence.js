function numberOfLongestSubsequence(nums) {
    if (nums.length === 0) return 0;

    const dp = new Array(nums.length).fill(1);
    const count = new Array(nums.length).fill(1);

    for (let i = 0; i < nums.length; i++) {
        for (let j = 0; j < i; j++) {
            if (nums[j] < nums[i]) {
                if (dp[j] + 1 > dp[i]) {
                    dp[i] = dp[j] + 1;
                    count[i] = count[j];
                } else if (dp[j] + 1 === dp[i]) {
                    count[i] += count[j];
                }
            }
        }
    }

    let maxLength = Math.max(...dp);
    let result = 0;

    for (let i = 0; i < dp.length; i++) {
        if (dp[i] === maxLength) {
            result += count[i];
        }
    }

    return result;
}