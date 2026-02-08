function maximumSubarraySum(nums) {
    let maxSum = -Infinity;
    let currentSum = 0;
    let removeCount = 0;
    let left = 0;

    for (let right = 0; right < nums.length; right++) {
        currentSum += nums[right];

        while (removeCount > 0) {
            currentSum -= nums[left];
            left++;
            removeCount--;
        }

        maxSum = Math.max(maxSum, currentSum);

        if (nums[right] === 0) {
            removeCount++;
        }
    }

    return maxSum;
}