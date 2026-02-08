function sumOfSquares(nums) {
    let sum = 0;
    for (let i = 0; i < nums.length; i++) {
        if (i % 2 === 0) {
            sum += nums[i] * nums[i];
        }
    }
    return sum;
}