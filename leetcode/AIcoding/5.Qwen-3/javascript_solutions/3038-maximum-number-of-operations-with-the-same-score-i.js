function maxOperations(nums) {
    let count = 0;
    let target = nums[0] + nums[1];
    for (let i = 0; i < nums.length; i += 2) {
        if (i + 1 < nums.length && nums[i] + nums[i + 1] === target) {
            count++;
        } else {
            break;
        }
    }
    return count;
}