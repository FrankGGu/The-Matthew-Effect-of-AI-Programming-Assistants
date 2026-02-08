function findPairs(nums, k) {
    const freq = {};
    let count = 0;

    for (const num of nums) {
        if (freq[num]) {
            freq[num]++;
        } else {
            freq[num] = 1;
        }
    }

    for (const key in freq) {
        const num = parseInt(key);
        if (k === 0) {
            if (freq[num] >= 2) {
                count++;
            }
        } else {
            if (freq[num + k]) {
                count++;
            }
        }
    }

    return count;
}