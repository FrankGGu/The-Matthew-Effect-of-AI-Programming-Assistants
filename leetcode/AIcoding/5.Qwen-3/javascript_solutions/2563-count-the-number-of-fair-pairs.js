function countFairPairs(nums, lower, upper) {
    const n = nums.length;
    let count = 0;
    for (let i = 0; i < n; i++) {
        for (let j = i + 1; j < n; j++) {
            if (lower <= nums[i] + nums[j] && nums[i] + nums[j] <= upper) {
                count++;
            }
        }
    }
    return count;
}