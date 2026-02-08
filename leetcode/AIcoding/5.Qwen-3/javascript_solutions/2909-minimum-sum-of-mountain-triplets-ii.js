function minimumSum(nums) {
    const n = nums.length;
    let minSum = Infinity;

    for (let i = 1; i < n - 1; i++) {
        let leftMin = nums[0];
        let rightMin = nums[n - 1];

        for (let j = 0; j < i; j++) {
            if (nums[j] < nums[i]) {
                leftMin = Math.min(leftMin, nums[j]);
            }
        }

        for (let j = n - 1; j > i; j--) {
            if (nums[j] < nums[i]) {
                rightMin = Math.min(rightMin, nums[j]);
            }
        }

        if (leftMin < nums[i] && nums[i] > rightMin) {
            minSum = Math.min(minSum, leftMin + nums[i] + rightMin);
        }
    }

    return minSum === Infinity ? -1 : minSum;
}