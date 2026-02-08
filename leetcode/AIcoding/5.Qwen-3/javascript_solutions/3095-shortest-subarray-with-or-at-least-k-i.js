function shortestSubarray(nums, k) {
    const n = nums.length;
    const prefix = new Array(n + 1).fill(0);
    for (let i = 0; i < n; ++i) {
        prefix[i + 1] = prefix[i] | nums[i];
    }

    let result = Infinity;
    for (let i = 0; i < n; ++i) {
        for (let j = i + 1; j <= n; ++j) {
            if ((prefix[j] & prefix[i]) === prefix[i]) {
                result = Math.min(result, j - i);
            }
        }
    }

    return result === Infinity ? -1 : result;
}