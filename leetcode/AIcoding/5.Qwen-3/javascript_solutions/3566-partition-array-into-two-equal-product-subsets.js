function canPartition(nums) {
    let total = nums.reduce((a, b) => a + b, 0);
    if (total % 2 !== 0) return false;
    let target = total / 2;
    let dp = new Set([0]);
    for (let num of nums) {
        for (let s of dp) {
            if (s + num === target) return true;
            if (s + num < target) dp.add(s + num);
        }
    }
    return false;
}