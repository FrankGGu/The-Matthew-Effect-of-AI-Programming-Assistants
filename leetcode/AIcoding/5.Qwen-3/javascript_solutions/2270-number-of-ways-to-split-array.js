function numberOfWays(nums) {
    const n = nums.length;
    let total = 0;
    for (let i = 0; i < n - 1; i++) {
        let left = 0;
        for (let j = 0; j <= i; j++) {
            left += nums[j];
        }
        let right = 0;
        for (let j = i + 1; j < n; j++) {
            right += nums[j];
        }
        if (left === right) {
            total++;
        }
    }
    return total;
}