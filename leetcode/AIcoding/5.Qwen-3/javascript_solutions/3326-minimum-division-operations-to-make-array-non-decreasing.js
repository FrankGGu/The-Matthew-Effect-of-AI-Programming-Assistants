function minDivisions(nums) {
    let count = 0;
    for (let i = nums.length - 2; i >= 0; i--) {
        if (nums[i] > nums[i + 1]) {
            count++;
            nums[i] = Math.floor(nums[i] / 2);
        }
    }
    return count;
}