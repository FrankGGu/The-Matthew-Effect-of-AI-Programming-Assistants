function minArrayLength(nums) {
    const count = new Map();
    for (const num of nums) {
        count.set(num, (count.get(num) || 0) + 1);
    }

    let result = 0;
    for (const [num, freq] of count.entries()) {
        result += Math.floor(freq / 2);
    }

    return nums.length - result * 2;
}