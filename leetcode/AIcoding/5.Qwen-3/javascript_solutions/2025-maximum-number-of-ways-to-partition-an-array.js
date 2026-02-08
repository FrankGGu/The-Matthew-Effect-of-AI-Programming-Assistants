function maxNumberOfWaysToPartition(nums) {
    const n = nums.length;
    const prefix = new Array(n + 1).fill(0);
    for (let i = 0; i < n; i++) {
        prefix[i + 1] = prefix[i] + nums[i];
    }

    const map = new Map();
    let result = 0;

    for (let i = 0; i < n - 1; i++) {
        const leftSum = prefix[i + 1];
        const rightSum = prefix[n] - leftSum;
        const diff = rightSum - leftSum;

        if (map.has(diff)) {
            result += map.get(diff);
        }

        const currentDiff = prefix[i + 1] - prefix[i];
        map.set(currentDiff, (map.get(currentDiff) || 0) + 1);
    }

    return result;
}