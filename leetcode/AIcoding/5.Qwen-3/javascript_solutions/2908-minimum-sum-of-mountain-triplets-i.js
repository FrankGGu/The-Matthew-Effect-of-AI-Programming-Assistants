function minSumOfMountainTriplet(nums) {
    const n = nums.length;
    let minSum = Infinity;

    for (let i = 1; i < n - 1; i++) {
        let leftMin = Infinity;
        let rightMin = Infinity;

        for (let j = 0; j < i; j++) {
            if (nums[j] < nums[i]) {
                leftMin = Math.min(leftMin, nums[j]);
            }
        }

        for (let k = i + 1; k < n; k++) {
            if (nums[k] < nums[i]) {
                rightMin = Math.min(rightMin, nums[k]);
            }
        }

        if (leftMin !== Infinity && rightMin !== Infinity) {
            minSum = Math.min(minSum, leftMin + nums[i] + rightMin);
        }
    }

    return minSum === Infinity ? -1 : minSum;
}