function maximumSum(nums) {
    const freq = {};
    for (const num of nums) {
        const digitSum = num.toString().split('').reduce((sum, ch) => sum + parseInt(ch), 0);
        if (!freq[digitSum]) {
            freq[digitSum] = [];
        }
        freq[digitSum].push(num);
    }

    let maxSum = -1;
    for (const key in freq) {
        if (freq[key].length >= 2) {
            freq[key].sort((a, b) => b - a);
            maxSum = Math.max(maxSum, freq[key][0] + freq[key][1]);
        }
    }

    return maxSum;
}