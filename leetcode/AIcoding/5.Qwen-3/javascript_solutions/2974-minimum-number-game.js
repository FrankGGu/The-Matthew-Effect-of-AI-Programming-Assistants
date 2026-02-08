function minNumber(nums) {
    nums.sort((a, b) => a - b);
    let result = 0;
    for (let i = 0; i < nums.length; i += 2) {
        result = result * 10 + nums[i];
    }
    return result;
}