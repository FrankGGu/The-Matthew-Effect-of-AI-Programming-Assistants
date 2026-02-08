var findLongestSubsequence = function(nums) {
    const count = {};
    for (const num of nums) {
        count[num] = (count[num] || 0) + 1;
    }
    let maxLength = 0;
    for (const key in count) {
        const num = parseInt(key);
        if (count[num + 1]) {
            maxLength = Math.max(maxLength, count[num] + count[num + 1]);
        }
    }
    return maxLength;
};