function maximumTotalReward(args) {
    const nums = args;
    nums.sort((a, b) => a - b);
    const dp = new Set([0]);
    for (const num of nums) {
        const temp = new Set(dp);
        for (const val of temp) {
            if (val < num) {
                dp.add(val + num);
            }
        }
    }
    return Math.max(...dp);
}