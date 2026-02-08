function sumOfSquares(nums) {
    const n = nums.length;
    let result = 0;
    for (let i = 0; i < n; i++) {
        let count = 0;
        for (let j = i; j < n; j++) {
            if (nums[j] === nums[i]) {
                count++;
            }
            result += count * count;
        }
    }
    return result;
}