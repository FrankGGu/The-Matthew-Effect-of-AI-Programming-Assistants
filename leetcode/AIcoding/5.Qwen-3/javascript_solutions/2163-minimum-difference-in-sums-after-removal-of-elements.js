function minimumDifference(nums) {
    const n = nums.length;
    const total = nums.reduce((a, b) => a + b, 0);

    const left = new Array(n).fill(0);
    const right = new Array(n).fill(0);

    let sum = 0;
    let min = Infinity;
    for (let i = 0; i < n; i++) {
        sum += nums[i];
        if (i % 2 === 0) {
            left[i] = sum;
            min = Math.min(min, sum);
        } else {
            left[i] = min;
        }
    }

    sum = 0;
    min = Infinity;
    for (let i = n - 1; i >= 0; i--) {
        sum += nums[i];
        if (i % 2 === 0) {
            right[i] = sum;
            min = Math.min(min, sum);
        } else {
            right[i] = min;
        }
    }

    let result = Infinity;
    for (let i = 0; i < n; i++) {
        const leftSum = i > 0 ? left[i - 1] : 0;
        const rightSum = i < n - 1 ? right[i + 1] : 0;
        const current = total - leftSum - rightSum - nums[i];
        result = Math.min(result, Math.abs(current));
    }

    return result;
}