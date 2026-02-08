function numberOfPairs(nums, target) {
    let count = 0;
    const map = new Map();

    for (const num of nums) {
        if (map.has(target.slice(num.length))) {
            count += map.get(target.slice(num.length));
        }
        map.set(num, (map.get(num) || 0) + 1);
    }

    return count;
}