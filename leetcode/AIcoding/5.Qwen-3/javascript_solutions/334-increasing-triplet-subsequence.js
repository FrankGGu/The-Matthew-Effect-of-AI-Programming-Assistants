function increasingTriplet(nums) {
    let first = Infinity, second = Infinity;
    for (let i = 0; i < nums.length; i++) {
        if (nums[i] <= first) {
            first = nums[i];
        } else if (nums[i] <= second) {
            second = nums[i];
        } else {
            return true;
        }
    }
    return false;
}