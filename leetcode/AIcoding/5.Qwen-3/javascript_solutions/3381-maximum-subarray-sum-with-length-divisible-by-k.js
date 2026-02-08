function maxSubarraySum(nums, k) {
    const n = nums.length;
    let maxSum = -Infinity;
    let prefixSum = 0;
    const map = new Map();
    map.set(0, -1);

    for (let i = 0; i < n; i++) {
        prefixSum += nums[i];
        const rem = prefixSum % k;
        if (rem < 0) rem += k;
        if (map.has(rem)) {
            const prevIndex = map.get(rem);
            const currentLength = i - prevIndex;
            if (currentLength % k === 0) {
                maxSum = Math.max(maxSum, prefixSum - (prefixSum - nums[i]));
            }
        } else {
            map.set(rem, i);
        }
    }

    return maxSum;
}