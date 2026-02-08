function findFinalArrayState(nums, k, queries) {
    const n = nums.length;
    const result = [];

    for (let q of queries) {
        if (q >= n) {
            result.push(0);
            continue;
        }

        let index = q;
        let operations = k;

        while (operations > 0 && index < n) {
            nums[index] *= 2;
            operations--;
            index++;
        }

        result.push(nums[q]);
    }

    return result;
}