function zeroArrayTransformationI(nums, queries) {
    const result = [];
    const n = nums.length;
    let total = 0;

    for (let i = 0; i < queries.length; i++) {
        const [k, val] = queries[i];
        total += val;
        let canMakeZero = true;

        for (let j = 0; j < n; j++) {
            if (nums[j] - total > 0) {
                canMakeZero = false;
                break;
            }
        }

        result.push(canMakeZero);
    }

    return result;
}