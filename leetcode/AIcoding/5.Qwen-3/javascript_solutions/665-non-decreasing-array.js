function checkPossibility(nums) {
    let count = 0;
    for (let i = 1; i < nums.length; i++) {
        if (nums[i] < nums[i - 1]) {
            if (count > 0) return false;
            if (i === 1 || nums[i] >= nums[i - 2]) {
                nums[i - 1] = nums[i];
            } else {
                nums[i] = nums[i - 1];
            }
            count++;
        }
    }
    return true;
}