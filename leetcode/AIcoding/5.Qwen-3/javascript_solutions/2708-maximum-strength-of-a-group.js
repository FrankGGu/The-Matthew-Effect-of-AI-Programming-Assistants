function maxStrength(nums) {
    if (nums.length === 1) return nums[0];

    nums.sort((a, b) => a - b);

    const n = nums.length;
    const product = (i, j) => nums[i] * nums[j];

    return Math.max(
        product(0, 1),
        product(n - 2, n - 1),
        product(0, n - 1)
    );
}