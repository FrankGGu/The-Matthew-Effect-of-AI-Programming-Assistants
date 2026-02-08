function minLengthAfterRemovals(nums) {
    const count = {};
    let maxFreq = 0;
    for (const num of nums) {
        count[num] = (count[num] || 0) + 1;
        maxFreq = Math.max(maxFreq, count[num]);
    }
    return Math.max(0, nums.length - 2 * maxFreq);
}