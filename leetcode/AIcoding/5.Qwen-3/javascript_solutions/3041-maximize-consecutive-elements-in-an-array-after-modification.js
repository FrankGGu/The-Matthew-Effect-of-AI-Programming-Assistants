function longestSubarray(nums, k) {
    let left = 0;
    let maxLen = 0;
    const freq = {};

    for (let right = 0; right < nums.length; right++) {
        const num = nums[right];
        freq[num] = (freq[num] || 0) + 1;

        while (freq[1] - freq[0] > k) {
            const leftNum = nums[left];
            freq[leftNum]--;
            if (freq[leftNum] === 0) delete freq[leftNum];
            left++;
        }

        maxLen = Math.max(maxLen, right - left + 1);
    }

    return maxLen;
}