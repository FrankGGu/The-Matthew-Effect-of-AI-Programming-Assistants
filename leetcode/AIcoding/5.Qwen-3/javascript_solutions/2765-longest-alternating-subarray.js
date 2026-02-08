var longestAlternatingSubarray = function(nums) {
    let maxLen = 1;
    let currentLen = 1;

    for (let i = 1; i < nums.length; i++) {
        if ((nums[i] > nums[i - 1] && nums[i - 1] < nums[i - 2]) || (nums[i] < nums[i - 1] && nums[i - 1] > nums[i - 2])) {
            currentLen++;
            maxLen = Math.max(maxLen, currentLen);
        } else {
            currentLen = 1;
        }
    }

    return maxLen;
};