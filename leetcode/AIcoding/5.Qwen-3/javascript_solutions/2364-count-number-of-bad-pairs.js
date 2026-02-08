function numIdenticalPairs(nums) {
    const count = {};
    let result = 0;
    for (const num of nums) {
        if (count[num]) {
            result += count[num];
            count[num]++;
        } else {
            count[num] = 1;
        }
    }
    return result;
}