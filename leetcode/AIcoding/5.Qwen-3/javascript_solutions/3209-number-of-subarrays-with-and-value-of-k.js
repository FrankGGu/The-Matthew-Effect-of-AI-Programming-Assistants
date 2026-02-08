function numberOfSubarraysWithAndValueK(nums, k) {
    let count = 0;
    let n = nums.length;
    for (let i = 0; i < n; i++) {
        let andVal = nums[i];
        if (andVal === k) count++;
        for (let j = i + 1; j < n; j++) {
            andVal &= nums[j];
            if (andVal === k) count++;
            if (andVal < k) break;
        }
    }
    return count;
}