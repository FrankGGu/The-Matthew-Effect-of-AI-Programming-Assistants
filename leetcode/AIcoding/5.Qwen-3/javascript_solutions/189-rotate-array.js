function rotate(nums, k) {
    k = k % nums.length;
    if (k === 0) return;
    const temp = nums.slice(-k);
    for (let i = nums.length - 1; i >= k; i--) {
        nums[i] = nums[i - k];
    }
    for (let i = 0; i < temp.length; i++) {
        nums[i] = temp[i];
    }
}