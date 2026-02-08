function minOperations(nums, k) {
    let operations = 0;
    while (nums.reduce((a, b) => a + b, 0) < k) {
        nums.sort((a, b) => b - a);
        nums[0] += 1;
        operations++;
    }
    return operations;
}