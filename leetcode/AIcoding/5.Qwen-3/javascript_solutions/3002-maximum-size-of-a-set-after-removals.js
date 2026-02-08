function maximumSizeSet(nums, m) {
    const freq = new Map();
    for (const num of nums) {
        freq.set(num, (freq.get(num) || 0) + 1);
    }

    const counts = Array.from(freq.values()).sort((a, b) => b - a);

    let res = 0;
    let i = 0;

    while (i < counts.length && m > 0) {
        if (counts[i] > 1) {
            res += 2;
            m -= 1;
        } else {
            res += 1;
            m -= 1;
        }
        i++;
    }

    return res;
}