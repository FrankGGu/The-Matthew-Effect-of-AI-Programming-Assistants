function isOneBitCharacter(nums) {
    let i = nums.length - 2;
    while (i >= 0 && nums[i] === 1) {
        i--;
    }
    return i < 0 || nums[i] === 0;
}