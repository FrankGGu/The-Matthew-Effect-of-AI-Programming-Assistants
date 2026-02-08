function minOperations(nums, k) {
    let count = 0;
    for (let i = 0; i < nums.length; i++) {
        if (nums[i] % k !== 0) {
            count += k - (nums[i] % k);
        }
    }
    return count;
}