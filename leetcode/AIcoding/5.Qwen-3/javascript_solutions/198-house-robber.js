function rob(nums) {
    if (nums.length === 0) return 0;
    if (nums.length === 1) return nums[0];
    if (nums.length === 2) return Math.max(nums[0], nums[1]);

    let prevPrev = nums[0];
    let prev = Math.max(nums[0], nums[1]);

    for (let i = 2; i < nums.length; i++) {
        let current = Math.max(prev, prevPrev + nums[i]);
        prevPrev = prev;
        prev = current;
    }

    return prev;
}