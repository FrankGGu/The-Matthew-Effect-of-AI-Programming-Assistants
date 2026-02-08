function countSubseqWithUniqueMiddleMode(nums) {
    const n = nums.length;
    const mod = 1000000007;
    let result = 0;

    for (let i = 0; i < n; i++) {
        const freq = {};
        let maxFreq = 0;
        let modeCount = 0;
        let total = 0;

        for (let j = i; j < n; j++) {
            const num = nums[j];
            freq[num] = (freq[num] || 0) + 1;
            if (freq[num] > maxFreq) {
                maxFreq = freq[num];
                modeCount = 1;
            } else if (freq[num] === maxFreq) {
                modeCount++;
            }

            if (modeCount === 1) {
                total = (total + 1) % mod;
            } else {
                total = (total - 1 + mod) % mod;
            }

            result = (result + total) % mod;
        }
    }

    return result;
}