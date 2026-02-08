function largestDivisibleSubset(nums) {
    if (nums.length === 0) return [];
    nums.sort((a, b) => a - b);
    const dp = Array(nums.length).fill(1);
    const prev = Array(nums.length).fill(-1);
    let maxIndex = 0;

    for (let i = 1; i < nums.length; i++) {
        for (let j = 0; j < i; j++) {
            if (nums[i] % nums[j] === 0 && dp[j] + 1 > dp[i]) {
                dp[i] = dp[j] + 1;
                prev[i] = j;
            }
        }
        if (dp[i] > dp[maxIndex]) {
            maxIndex = i;
        }
    }

    const result = [];
    while (maxIndex !== -1) {
        result.push(nums[maxIndex]);
        maxIndex = prev[maxIndex];
    }
    return result.reverse();
}