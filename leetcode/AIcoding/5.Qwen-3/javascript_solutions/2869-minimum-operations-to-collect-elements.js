function minimumOperations(nums) {
    const n = nums.length;
    const target = new Set([1, 2, 3, 4, 5]);
    const lastIndices = new Array(6).fill(-1);

    for (let i = n - 1; i >= 0; i--) {
        if (target.has(nums[i])) {
            lastIndices[nums[i]] = i;
        }
    }

    let operations = 0;
    let currentIndex = n - 1;

    while (target.size > 0) {
        let minIndex = Infinity;
        let valueToTake = -1;

        for (let i = 1; i <= 5; i++) {
            if (lastIndices[i] !== -1 && lastIndices[i] < minIndex) {
                minIndex = lastIndices[i];
                valueToTake = i;
            }
        }

        if (minIndex === Infinity) break;

        operations += currentIndex - minIndex + 1;
        currentIndex = minIndex - 1;
        target.delete(valueToTake);
    }

    return operations;
}