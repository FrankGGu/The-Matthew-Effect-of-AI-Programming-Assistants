function countBeautifulSubarrays(nums, k) {
    const prefixXOR = [];
    let xor = 0;
    for (let num of nums) {
        xor ^= num;
        prefixXOR.push(xor);
    }

    const map = new Map();
    map.set(0, 1);
    let result = 0;

    for (let i = 0; i < prefixXOR.length; i++) {
        const target = prefixXOR[i] ^ k;
        if (map.has(target)) {
            result += map.get(target);
        }
        map.set(prefixXOR[i], (map.get(prefixXOR[i]) || 0) + 1);
    }

    return result;
}