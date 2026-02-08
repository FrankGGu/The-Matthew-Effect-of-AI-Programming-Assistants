function arrayNesting(nums) {
    let maxLen = 0;
    const n = nums.length;
    for (let i = 0; i < n; i++) {
        if (nums[i] === -1) continue;
        let j = i;
        let count = 0;
        while (nums[j] !== -1) {
            const next = nums[j];
            nums[j] = -1;
            j = next;
            count++;
        }
        maxLen = Math.max(maxLen, count);
    }
    return maxLen;
}