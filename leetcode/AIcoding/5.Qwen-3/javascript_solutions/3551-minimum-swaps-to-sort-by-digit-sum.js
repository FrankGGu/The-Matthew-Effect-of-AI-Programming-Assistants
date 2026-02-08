function minimumSwapsToSortByDigitSum(nums) {
    const n = nums.length;
    const digitSums = new Array(n);
    for (let i = 0; i < n; i++) {
        let sum = 0;
        let num = nums[i];
        while (num > 0) {
            sum += num % 10;
            num = Math.floor(num / 10);
        }
        digitSums[i] = sum;
    }

    const indices = [...Array(n).keys()];
    indices.sort((a, b) => digitSums[a] - digitSums[b] || nums[a] - nums[b]);

    const pos = new Array(n);
    for (let i = 0; i < n; i++) {
        pos[indices[i]] = i;
    }

    let swaps = 0;
    for (let i = 0; i < n; i++) {
        if (pos[i] !== i) {
            const j = pos[i];
            [nums[i], nums[j]] = [nums[j], nums[i]];
            [pos[i], pos[j]] = [pos[j], pos[i]];
            swaps++;
        }
    }

    return swaps;
}