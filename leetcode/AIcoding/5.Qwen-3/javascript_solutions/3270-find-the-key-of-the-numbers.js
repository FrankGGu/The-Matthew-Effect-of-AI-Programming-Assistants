function findKey(nums, k) {
    const map = new Map();
    for (let num of nums) {
        if (map.has(num)) {
            map.set(num, map.get(num) + 1);
        } else {
            map.set(num, 1);
        }
    }
    for (let [key, value] of map.entries()) {
        if (value === k) {
            return key;
        }
    }
    return -1;
}