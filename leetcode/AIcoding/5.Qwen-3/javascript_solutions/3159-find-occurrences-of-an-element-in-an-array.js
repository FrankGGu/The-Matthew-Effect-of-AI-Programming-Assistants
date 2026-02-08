function findOccurrences(nums, x) {
    const result = [];
    for (let i = 0; i < nums.length; i++) {
        if (nums[i] === x) {
            result.push(i);
        }
    }
    return result;
}