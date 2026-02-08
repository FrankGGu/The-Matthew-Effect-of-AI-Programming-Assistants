function minOperations(x, y, nums) {
    const map = new Map();
    for (let num of nums) {
        if (map.has(num)) {
            map.set(num, map.get(num) + 1);
        } else {
            map.set(num, 1);
        }
    }

    let operations = 0;
    for (let i = 0; i < 32; i++) {
        const bitX = (x >> i) & 1;
        const bitY = (y >> i) & 1;

        if (bitX === bitY) continue;

        if (bitX === 1) {
            if (map.has(1 << i)) {
                map.set(1 << i, map.get(1 << i) - 1);
                if (map.get(1 << i) === 0) map.delete(1 << i);
                operations++;
            } else {
                return -1;
            }
        } else {
            if (map.has(1 << i)) {
                map.set(1 << i, map.get(1 << i) - 1);
                if (map.get(1 << i) === 0) map.delete(1 << i);
                operations++;
            } else {
                return -1;
            }
        }
    }

    return operations;
}