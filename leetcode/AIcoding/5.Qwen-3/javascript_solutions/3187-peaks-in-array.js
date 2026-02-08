function peaksInArray(nums) {
    const n = nums.length;
    const result = [];

    for (let i = 1; i < n - 1; i++) {
        if (nums[i] > nums[i - 1] && nums[i] > nums[i + 1]) {
            result.push(i);
        }
    }

    return result;
}