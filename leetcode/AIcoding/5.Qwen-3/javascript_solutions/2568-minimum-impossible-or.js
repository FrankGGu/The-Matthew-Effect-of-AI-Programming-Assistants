function minImpossibleOR(nums) {
    const set = new Set(nums);
    let result = 1;
    while (set.has(result)) {
        result <<= 1;
    }
    return result;
}