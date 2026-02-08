var minMoves2 = function(nums) {
    nums.sort((a, b) => a - b);
    const mid = nums[Math.floor(nums.length / 2)];
    return nums.reduce((sum, num) => sum + Math.abs(num - mid), 0);
};