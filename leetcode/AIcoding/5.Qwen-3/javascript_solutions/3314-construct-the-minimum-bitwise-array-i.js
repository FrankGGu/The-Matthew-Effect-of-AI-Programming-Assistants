function minBitwiseArray(nums) {
    const result = [];
    for (let i = 0; i < nums.length; i++) {
        let minVal = nums[i];
        for (let j = 0; j <= 30; j++) {
            if ((nums[i] & (1 << j)) === 0) {
                const candidate = nums[i] | (1 << j);
                if (candidate < minVal) {
                    minVal = candidate;
                }
            }
        }
        result.push(minVal);
    }
    return result;
}