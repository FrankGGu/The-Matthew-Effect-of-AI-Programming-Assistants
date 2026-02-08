function maxSumAfterOperations(nums, k) {
    const MOD = 10 ** 9 + 7;
    const n = nums.length;
    let maxSum = 0;

    for (let i = 0; i < n; i++) {
        let current = nums[i];
        for (let j = 0; j < k; j++) {
            current = (current + 1) % MOD;
        }
        maxSum = (maxSum + current * current) % MOD;
    }

    return maxSum;
}