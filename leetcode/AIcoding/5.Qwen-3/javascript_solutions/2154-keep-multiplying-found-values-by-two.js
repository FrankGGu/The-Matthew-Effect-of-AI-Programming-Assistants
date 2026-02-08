function findFinalValue(nums, original) {
    const set = new Set(nums);
    while (set.has(original)) {
        original *= 2;
    }
    return original;
}