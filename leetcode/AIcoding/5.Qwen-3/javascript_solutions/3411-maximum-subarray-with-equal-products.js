function maxSubarrayWithEqualProducts(nums) {
    let maxLen = 0;
    const n = nums.length;

    for (let i = 0; i < n; i++) {
        let product = 1;
        for (let j = i; j < n; j++) {
            product *= nums[j];
            if (product === 0) break;
            if (product > 0) {
                maxLen = Math.max(maxLen, j - i + 1);
            }
        }
    }

    return maxLen;
}