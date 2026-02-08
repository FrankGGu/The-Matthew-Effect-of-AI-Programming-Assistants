function sumQueriesHandler(nums) {
    const prefixSum = [];
    let sum = 0;
    for (let i = 0; i < nums.length; i++) {
        sum += nums[i];
        prefixSum.push(sum);
    }

    return function updateAndQuery(indices, values) {
        for (let i = 0; i < indices.length; i++) {
            const idx = indices[i];
            const val = values[i];
            nums[idx] += val;
            for (let j = idx; j < prefixSum.length; j++) {
                prefixSum[j] += val;
            }
        }

        return prefixSum;
    };
}