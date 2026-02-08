function minIncrements(nums, target) {
    let count = 0;
    let sum = 0;
    for (let i = 0; i < nums.length; i++) {
        sum += nums[i];
    }
    if (sum >= target) return 0;
    const needed = target - sum;
    nums.sort((a, b) => a - b);
    for (let i = 0; i < nums.length && needed > 0; i++) {
        const next = nums[i + 1] || Infinity;
        const diff = next - nums[i];
        const add = Math.min(diff, needed);
        count += add;
        needed -= add;
        nums[i] += add;
    }
    return count;
}