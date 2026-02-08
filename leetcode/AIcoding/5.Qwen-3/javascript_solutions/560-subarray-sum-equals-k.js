function subarraySum(nums, k) {
    let count = 0;
    let sum = 0;
    const prefixSum = new Map();
    prefixSum.set(0, 1);

    for (const num of nums) {
        sum += num;
        if (prefixSum.has(sum - k)) {
            count += prefixSum.get(sum - k);
        }
        prefixSum.set(sum, (prefixSum.get(sum) || 0) + 1);
    }

    return count;
}