function mostFrequent(nums, key) {
    const count = {};
    let maxFreq = 0;
    let result = -1;

    for (let i = 0; i < nums.length; i++) {
        if (nums[i] === key) {
            const nextNum = nums[i + 1];
            if (nextNum !== undefined) {
                count[nextNum] = (count[nextNum] || 0) + 1;
                if (count[nextNum] > maxFreq) {
                    maxFreq = count[nextNum];
                    result = nextNum;
                } else if (count[nextNum] === maxFreq && nextNum < result) {
                    result = nextNum;
                }
            }
        }
    }

    return result;
}