var sortArrayByParity = function(nums) {
    return nums.sort((a, b) => a % 2 - b % 2);
};