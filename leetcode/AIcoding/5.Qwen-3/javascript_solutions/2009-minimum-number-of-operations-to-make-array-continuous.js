function minOperations(nums, numsDivide) {
    nums.sort((a, b) => a - b);
    numsDivide.sort((a, b) => a - b);

    const target = numsDivide[0];
    let minOps = Infinity;

    for (let i = 0; i < nums.length; i++) {
        if (nums[i] > target) break;
        if (target % nums[i] === 0) {
            let ops = 0;
            for (let j = 0; j < nums.length; j++) {
                if (nums[j] !== nums[i]) {
                    ops++;
                }
            }
            minOps = Math.min(minOps, ops);
        }
    }

    return minOps;
}