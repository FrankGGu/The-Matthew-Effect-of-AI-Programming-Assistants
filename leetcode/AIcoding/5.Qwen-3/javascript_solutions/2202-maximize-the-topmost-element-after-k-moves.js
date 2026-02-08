function maximumTop(nums, k) {
    if (nums.length === 1) {
        return k % 2 === 0 ? nums[0] : -1;
    }
    if (k === 0) {
        return nums[0];
    }
    if (k >= nums.length) {
        return Math.max(...nums);
    }
    let max = -1;
    for (let i = 0; i < k; i++) {
        max = Math.max(max, nums[i]);
    }
    return max;
}