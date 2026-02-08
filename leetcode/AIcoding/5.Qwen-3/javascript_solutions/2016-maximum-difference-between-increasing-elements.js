function maximumDifference(nums) {
    let min = nums[0];
    let maxDiff = -1;

    for (let i = 1; i < nums.length; i++) {
        if (nums[i] > min) {
            maxDiff = Math.max(maxDiff, nums[i] - min);
        } else {
            min = nums[i];
        }
    }

    return maxDiff;
}