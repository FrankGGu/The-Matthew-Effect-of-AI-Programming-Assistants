function minOperations(nums) {
    const count = {};
    let operations = 0;
    for (let i = 0; i < nums.length; i++) {
        if (count[nums[i]] === undefined) {
            count[nums[i]] = 1;
        } else {
            let current = nums[i];
            while (count[current] !== undefined) {
                current++;
                operations++;
            }
            count[current] = 1;
        }
    }
    return operations;
}