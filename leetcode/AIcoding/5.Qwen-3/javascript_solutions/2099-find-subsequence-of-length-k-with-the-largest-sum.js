function maxSubsequence(nums, k) {
    const indices = Array.from({ length: nums.length }, (_, i) => i);
    indices.sort((a, b) => nums[b] - nums[a]);
    const selected = indices.slice(0, k).sort((a, b) => a - b);
    return selected.map(i => nums[i]);
}