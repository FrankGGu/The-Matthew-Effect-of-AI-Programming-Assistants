function smallestSubarrays(nums) {
    const n = nums.length;
    const result = new Array(n).fill(0);

    for (let i = 0; i < n; i++) {
        let currentOr = 0;
        for (let j = i; j < n; j++) {
            currentOr |= nums[j];
            result[i] = Math.max(result[i], j - i + 1);
        }
    }

    return result;
}