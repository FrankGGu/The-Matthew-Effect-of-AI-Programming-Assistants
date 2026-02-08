function minPatches(nums, n) {
    let patches = 0;
    let miss = 1;
    let i = 0;

    while (miss <= n) {
        if (i < nums.length && nums[i] <= miss) {
            miss += nums[i];
            i++;
        } else {
            miss += miss;
            patches++;
        }
    }

    return patches;
}