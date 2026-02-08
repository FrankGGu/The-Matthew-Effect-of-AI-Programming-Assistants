function rearrangeArray(nums) {
    for (let i = 1; i < nums.length - 1; i++) {
        if (nums[i] * 2 === nums[i - 1] + nums[i + 1]) {
            [nums[i], nums[i + 1]] = [nums[i + 1], nums[i]];
        }
    }
    return nums;
}