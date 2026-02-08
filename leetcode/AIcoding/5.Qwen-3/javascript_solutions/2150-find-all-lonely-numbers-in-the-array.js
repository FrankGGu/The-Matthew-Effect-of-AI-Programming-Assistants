function findLonely(nums) {
    const count = new Map();
    for (const num of nums) {
        count.set(num, (count.get(num) || 0) + 1);
    }
    const result = [];
    for (const num of nums) {
        if (count.get(num) === 1 && !count.has(num - 1) && !count.has(num + 1)) {
            result.push(num);
        }
    }
    return result;
}