function minOperations(nums) {
    let operations = 0;
    for (let i = 0; i < nums.length; i++) {
        if (nums[i] === 0) continue;
        operations += nums[i];
        for (let j = i + 1; j < nums.length; j++) {
            nums[j] -= nums[i];
        }
    }
    return operations;
}