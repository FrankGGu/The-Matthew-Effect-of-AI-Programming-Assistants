function minOperations(nums, threshold) {
    let operations = 0;
    let sum = 0;
    for (let i = 0; i < nums.length; i++) {
        sum += nums[i];
        if (sum > threshold) {
            operations++;
            sum = 0;
        }
    }
    return operations;
}