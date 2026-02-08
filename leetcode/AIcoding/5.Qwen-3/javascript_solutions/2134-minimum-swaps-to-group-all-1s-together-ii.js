function minSwaps(nums) {
    const n = nums.length;
    let totalOnes = 0;

    for (const num of nums) {
        if (num === 1) totalOnes++;
    }

    if (totalOnes === 0 || totalOnes === n) return 0;

    let maxOnes = 0;
    let currentOnes = 0;

    for (let i = 0; i < n; i++) {
        if (nums[i] === 1) currentOnes++;

        if (i >= totalOnes) {
            if (nums[i - totalOnes] === 1) currentOnes--;
        }

        maxOnes = Math.max(maxOnes, currentOnes);
    }

    return totalOnes - maxOnes;
}