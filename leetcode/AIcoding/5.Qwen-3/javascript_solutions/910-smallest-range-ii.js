function smallestRangeII(nums, k) {
    nums.sort((a, b) => a - b);
    let n = nums.length;
    let min = nums[n - 1] - nums[0];
    for (let i = 0; i < n - 1; i++) {
        let low = Math.min(nums[0] + k, nums[i + 1] - k);
        let high = Math.max(nums[n - 1] - k, nums[i] + k);
        min = Math.min(min, high - low);
    }
    return min;
}