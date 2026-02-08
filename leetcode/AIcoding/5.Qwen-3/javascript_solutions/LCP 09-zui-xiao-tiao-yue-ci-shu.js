function jump(nums) {
    let steps = 0;
    let currentEnd = 0;
    let farthest = 0;
    for (let i = 0; i < nums.length - 1; i++) {
        farthest = Math.max(farthest, i + nums[i]);
        if (i === currentEnd) {
            steps++;
            currentEnd = farthest;
        }
    }
    return steps;
}