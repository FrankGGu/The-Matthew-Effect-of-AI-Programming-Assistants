function findSpeed(nums) {
    const n = nums.length;
    const res = new Array(n).fill(0);
    const map = new Map();

    for (let i = 0; i < n; i++) {
        if (map.has(nums[i])) {
            const prev = map.get(nums[i]);
            res[i] = i - prev;
            res[prev] = i - prev;
        } else {
            res[i] = 0;
        }
        map.set(nums[i], i);
    }

    return res;
}