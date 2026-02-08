function countTriplets(nums) {
    const n = nums.length;
    const xorMap = new Map();
    let count = 0;

    for (let i = 0; i < n; i++) {
        for (let j = i + 1; j < n; j++) {
            const xor = nums[i] ^ nums[j];
            if (xorMap.has(xor)) {
                count += xorMap.get(xor);
            } else {
                xorMap.set(xor, 0);
            }
        }
        for (let j = 0; j < n; j++) {
            const xor = nums[i] ^ nums[j];
            if (xorMap.has(xor)) {
                xorMap.set(xor, xorMap.get(xor) + 1);
            } else {
                xorMap.set(xor, 1);
            }
        }
    }

    return count;
}