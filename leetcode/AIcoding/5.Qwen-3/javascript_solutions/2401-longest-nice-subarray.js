function longestNiceSubarray(nums) {
    const n = nums.length;
    let maxLen = 0;
    let mask = 0;
    let left = 0;

    for (let right = 0; right < n; right++) {
        while ((mask & nums[right]) !== 0) {
            mask ^= nums[left];
            left++;
        }
        mask |= nums[right];
        maxLen = Math.max(maxLen, right - left + 1);
    }

    return maxLen;
}