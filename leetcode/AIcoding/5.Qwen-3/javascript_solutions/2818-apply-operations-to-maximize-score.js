function maximumScore(nums, k) {
    const n = nums.length;
    const left = new Array(n).fill(0);
    const right = new Array(n).fill(0);

    let count = 0;
    for (let i = 0; i < n; i++) {
        if (i === 0 || nums[i] < nums[i - 1]) {
            count = 0;
        }
        left[i] = count++;
    }

    count = 0;
    for (let i = n - 1; i >= 0; i--) {
        if (i === n - 1 || nums[i] < nums[i + 1]) {
            count = 0;
        }
        right[i] = count++;
    }

    let maxScore = 0;
    for (let i = 0; i < n; i++) {
        const minVal = Math.min(nums[i], nums[k]);
        const length = left[i] + right[i] + 1;
        maxScore = Math.max(maxScore, minVal * length);
    }

    return maxScore;
}