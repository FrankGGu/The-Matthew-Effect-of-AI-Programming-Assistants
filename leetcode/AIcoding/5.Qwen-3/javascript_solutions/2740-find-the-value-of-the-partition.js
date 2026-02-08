var partialTraversal = function(nums) {
    nums.sort((a, b) => a - b);
    let result = 0;
    for (let i = 1; i < nums.length; i++) {
        result += nums[i] - nums[i - 1];
    }
    return result;
};