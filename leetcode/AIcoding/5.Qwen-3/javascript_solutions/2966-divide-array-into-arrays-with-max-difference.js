function divideArray(nums, k) {
    nums.sort((a, b) => a - b);
    const result = [];
    for (let i = 0; i < nums.length; i += k) {
        const sub = [];
        for (let j = 0; j < k; j++) {
            sub.push(nums[i + j]);
        }
        result.push(sub);
    }
    return result;
}