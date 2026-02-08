function maximizeActiveSectionWithTradeI(nums) {
    let max = 0;
    let left = 0;
    let right = 0;
    const n = nums.length;
    const freq = {};

    while (right < n) {
        const num = nums[right];
        freq[num] = (freq[num] || 0) + 1;

        while (freq[num] > 1) {
            const leftNum = nums[left];
            freq[leftNum]--;
            if (freq[leftNum] === 0) {
                delete freq[leftNum];
            }
            left++;
        }

        max = Math.max(max, right - left + 1);
        right++;
    }

    return max;
}