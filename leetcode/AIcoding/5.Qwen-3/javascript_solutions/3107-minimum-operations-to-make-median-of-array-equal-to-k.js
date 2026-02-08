function minOperations(nums, k) {
    nums.sort((a, b) => a - b);
    const n = nums.length;
    const mid = Math.floor(n / 2);
    let operations = 0;

    for (let i = 0; i <= mid; i++) {
        if (nums[i] < k) {
            operations += k - nums[i];
        } else if (nums[i] > k) {
            operations += nums[i] - k;
        }
    }

    return operations;
}