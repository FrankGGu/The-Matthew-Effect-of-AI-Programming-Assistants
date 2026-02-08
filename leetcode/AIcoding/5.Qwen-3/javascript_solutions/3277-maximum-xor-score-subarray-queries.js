function maxXORSubarrayQueries(nums, queries) {
    const n = nums.length;
    const result = new Array(queries.length).fill(0);
    const prefix = new Array(n + 1).fill(0);

    for (let i = 0; i < n; i++) {
        prefix[i + 1] = prefix[i] ^ nums[i];
    }

    for (let q = 0; q < queries.length; q++) {
        const [l, r] = queries[q];
        let max = 0;
        for (let i = l; i <= r; i++) {
            let current = 0;
            for (let j = i; j <= r; j++) {
                current ^= nums[j];
                max = Math.max(max, current);
            }
        }
        result[q] = max;
    }

    return result;
}