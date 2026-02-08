function isPossibleToSplit(nums) {
    const count = {};
    for (const num of nums) {
        count[num] = (count[num] || 0) + 1;
    }
    for (const key in count) {
        if (count[key] > 2) {
            return false;
        }
    }
    return true;
}