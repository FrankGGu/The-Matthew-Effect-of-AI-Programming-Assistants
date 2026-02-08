function canPartitionKSubsets(nums, k) {
    const sum = nums.reduce((a, b) => a + b, 0);
    if (sum % k !== 0) return false;
    const target = sum / k;
    nums.sort((a, b) => b - a);
    const used = new Array(nums.length).fill(false);

    function backtrack(start, currentSum, count) {
        if (count === k) return true;
        if (currentSum === target) {
            return backtrack(0, 0, count + 1);
        }
        for (let i = start; i < nums.length; i++) {
            if (!used[i] && currentSum + nums[i] <= target) {
                used[i] = true;
                if (backtrack(i + 1, currentSum + nums[i], count)) return true;
                used[i] = false;
            }
        }
        return false;
    }

    return backtrack(0, 0, 0);
}