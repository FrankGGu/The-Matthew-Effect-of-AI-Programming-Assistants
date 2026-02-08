function findMinimumOperations(nums) {
    if (nums.length === 0) return 0;
    let operations = 0;
    let i = 0;
    while (i < nums.length) {
        let j = i;
        while (j < nums.length && nums[j] === nums[i]) {
            j++;
        }
        if (j - i > 1) {
            operations += 1;
        }
        i = j;
    }
    return operations;
}