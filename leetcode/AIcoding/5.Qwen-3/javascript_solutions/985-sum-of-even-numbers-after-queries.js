function sumEvenAfterQueries(nums, queries) {
    let evenSum = 0;
    for (let num of nums) {
        if (num % 2 === 0) {
            evenSum += num;
        }
    }

    const result = [];
    for (let [val, index] of queries) {
        if (nums[index] % 2 === 0) {
            evenSum -= nums[index];
        }
        nums[index] += val;
        if (nums[index] % 2 === 0) {
            evenSum += nums[index];
        }
        result.push(evenSum);
    }

    return result;
}