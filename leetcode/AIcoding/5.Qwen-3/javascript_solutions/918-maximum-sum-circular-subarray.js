function maxSubarraySumCircular(nums) {
    let total = 0, maxSum = nums[0], minSum = nums[0], currMax = nums[0], currMin = nums[0];

    for (let i = 1; i < nums.length; i++) {
        currMax = Math.max(nums[i], currMax + nums[i]);
        maxSum = Math.max(maxSum, currMax);

        currMin = Math.min(nums[i], currMin + nums[i]);
        minSum = Math.min(minSum, currMin);

        total += nums[i];
    }

    if (maxSum < 0) {
        return maxSum;
    } else {
        return Math.max(maxSum, total - minSum);
    }
}