function countDistinctIntegers(nums) {
    const set = new Set(nums);
    for (const num of nums) {
        let reversed = 0;
        let n = num;
        while (n > 0) {
            reversed = reversed * 10 + n % 10;
            n = Math.floor(n / 10);
        }
        set.add(reversed);
    }
    return set.size;
}