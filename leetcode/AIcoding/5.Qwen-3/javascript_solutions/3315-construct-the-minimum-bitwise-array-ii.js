function minBitwiseArray(nums) {
    const n = nums.length;
    const result = new Array(n).fill(0);
    for (let i = 0; i < n; i++) {
        let minVal = nums[i];
        for (let j = 0; j < 32; j++) {
            if ((nums[i] & (1 << j)) === 0) {
                const candidate = nums[i] | (1 << j);
                if (candidate < minVal) {
                    minVal = candidate;
                }
            }
        }
        result[i] = minVal;
    }
    return result;
}