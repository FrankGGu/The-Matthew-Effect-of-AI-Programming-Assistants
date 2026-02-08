function sumOfSquareDistinctElements(nums) {
    let total = 0;
    const n = nums.length;
    for (let i = 0; i < n; i++) {
        const set = new Set();
        for (let j = i; j < n; j++) {
            set.add(nums[j]);
            total += set.size * set.size;
        }
    }
    return total;
}