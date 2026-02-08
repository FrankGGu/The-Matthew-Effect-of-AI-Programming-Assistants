function maxGreatness(nums) {
    const count = {};
    for (const num of nums) {
        count[num] = (count[num] || 0) + 1;
    }
    let result = 0;
    for (const num in count) {
        const n = parseInt(num);
        if (count[n + 1]) {
            result += Math.min(count[n], count[n + 1]);
        }
    }
    return result;
}