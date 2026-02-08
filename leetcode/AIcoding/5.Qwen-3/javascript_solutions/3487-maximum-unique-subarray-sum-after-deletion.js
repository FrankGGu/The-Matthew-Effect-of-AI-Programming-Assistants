function maximumUniqueSubarray(nums) {
    const n = nums.length;
    const prefixSum = new Array(n + 1).fill(0);
    for (let i = 0; i < n; i++) {
        prefixSum[i + 1] = prefixSum[i] + nums[i];
    }

    const lastOccurrence = {};
    let maxSum = 0;
    let left = 0;

    for (let right = 0; right < n; right++) {
        if (lastOccurrence.hasOwnProperty(nums[right])) {
            left = Math.max(left, lastOccurrence[nums[right]] + 1);
        }
        lastOccurrence[nums[right]] = right;
        maxSum = Math.max(maxSum, prefixSum[right + 1] - prefixSum[left]);
    }

    return maxSum;
}