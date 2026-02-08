function findXValue(nums) {
    const freq = {};
    for (const num of nums) {
        freq[num] = (freq[num] || 0) + 1;
    }

    let result = -1;
    let maxCount = 0;

    for (const key in freq) {
        const count = freq[key];
        if (count > maxCount) {
            maxCount = count;
            result = parseInt(key);
        } else if (count === maxCount && parseInt(key) < result) {
            result = parseInt(key);
        }
    }

    return result;
}