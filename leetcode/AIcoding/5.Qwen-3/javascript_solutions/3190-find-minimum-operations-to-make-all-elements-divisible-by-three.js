function minOperations(nums) {
    let count = 0;
    for (let i = 0; i < nums.length; i++) {
        if (nums[i] % 3 !== 0) {
            count++;
            nums[i] += 1;
        }
    }
    return count;
}