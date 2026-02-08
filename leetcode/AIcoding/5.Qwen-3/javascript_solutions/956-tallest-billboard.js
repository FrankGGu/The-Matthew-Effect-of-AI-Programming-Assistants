function tallestBillboard(nums) {
    const dp = new Map();
    dp.set(0, 0);
    for (const num of nums) {
        const newDp = new Map(dp);
        for (const [diff, max] of dp) {
            const newDiff = diff + num;
            const newMax = Math.max(max, newDp.get(newDiff) || 0);
            newDp.set(newDiff, newMax);
            const newDiff2 = Math.abs(diff - num);
            const newMax2 = Math.max(max, newDp.get(newDiff2) || 0);
            newDp.set(newDiff2, newMax2);
        }
        dp.clear();
        for (const [k, v] of newDp) {
            dp.set(k, v);
        }
    }
    return dp.get(0) || 0;
}