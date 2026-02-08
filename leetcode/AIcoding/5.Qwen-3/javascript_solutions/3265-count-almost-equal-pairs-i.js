function countAlmostEqualPairs(nums) {
    let count = 0;
    const n = nums.length;
    for (let i = 0; i < n; i++) {
        for (let j = i + 1; j < n; j++) {
            let diff = 0;
            for (let k = 0; k < 32; k++) {
                if ((nums[i] >> k & 1) !== (nums[j] >> k & 1)) {
                    diff++;
                }
            }
            if (diff <= 2) {
                count++;
            }
        }
    }
    return count;
}