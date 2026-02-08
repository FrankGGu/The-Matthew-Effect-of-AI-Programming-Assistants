var minimizeArrayValue = function(nums) {
    let max = 0, sum = 0;
    for (let i = 0; i < nums.length; i++) {
        sum += nums[i];
        max = Math.max(max, Math.ceil(sum / (i + 1)));
    }
    return max;
};