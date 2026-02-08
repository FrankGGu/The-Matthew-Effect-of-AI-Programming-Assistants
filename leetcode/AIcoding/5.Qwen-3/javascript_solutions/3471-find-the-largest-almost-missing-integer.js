function findLargestAlmostMissingInteger(nums) {
    const count = {};
    for (const num of nums) {
        count[num] = (count[num] || 0) + 1;
    }
    let max = -Infinity;
    for (const key in count) {
        const num = parseInt(key);
        if (count[num] === 1 && num > max) {
            max = num;
        }
    }
    return max === -Infinity ? -1 : max;
}