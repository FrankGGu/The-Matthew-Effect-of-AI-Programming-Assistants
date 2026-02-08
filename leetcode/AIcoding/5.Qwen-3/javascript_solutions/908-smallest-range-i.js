function smallestRangeI(nums, k) {
    const min = Math.min(...nums);
    const max = Math.max(...nums);
    return Math.max(0, max - min - 2 * k);
}