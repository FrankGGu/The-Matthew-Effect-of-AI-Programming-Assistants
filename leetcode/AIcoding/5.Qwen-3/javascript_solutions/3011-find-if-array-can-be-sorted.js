function canBeSorted(nums) {
    const n = nums.length;
    const sorted = [...nums].sort((a, b) => a - b);

    for (let i = 0; i < n; i++) {
        if (nums[i] !== sorted[i]) {
            let j = i + 1;
            while (j < n && nums[j] === sorted[j]) {
                j++;
            }
            if (j === n) return false;
            [nums[i], nums[j]] = [nums[j], nums[i]];
        }
    }

    return true;
}