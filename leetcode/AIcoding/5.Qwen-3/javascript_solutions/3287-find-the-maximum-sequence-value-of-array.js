function maximumSequenceValue(nums) {
    let maxVal = 0;
    for (let i = 0; i < nums.length; i++) {
        let current = nums[i];
        maxVal = Math.max(maxVal, current);
        for (let j = i + 1; j < nums.length; j++) {
            current ^= nums[j];
            maxVal = Math.max(maxVal, current);
        }
    }
    return maxVal;
}