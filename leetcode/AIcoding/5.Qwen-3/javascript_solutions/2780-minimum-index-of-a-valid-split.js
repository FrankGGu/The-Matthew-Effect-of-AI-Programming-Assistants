function findValidSplit(nums) {
    const n = nums.length;
    let leftSum = 0;
    let rightSum = nums.reduce((a, b) => a + b, 0);

    for (let i = 0; i < n; i++) {
        leftSum += nums[i];
        rightSum -= nums[i];
        if (leftSum === rightSum) {
            return i;
        }
    }

    return -1;
}