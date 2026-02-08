function minXORSum(nums1, nums2) {
    const n = nums1.length;
    const m = nums2.length;
    const dp = new Array(1 << m).fill(Infinity);
    dp[0] = 0;

    for (let i = 0; i < n; i++) {
        const nextDp = new Array(1 << m).fill(Infinity);
        for (let mask = 0; mask < (1 << m); mask++) {
            if (dp[mask] === Infinity) continue;
            for (let j = 0; j < m; j++) {
                if (!(mask & (1 << j))) {
                    const newMask = mask | (1 << j);
                    nextDp[newMask] = Math.min(nextDp[newMask], dp[mask] + (nums1[i] ^ nums2[j]));
                }
            }
        }
        dp.splice(0, dp.length, ...nextDp);
    }

    return dp[(1 << m) - 1];
}