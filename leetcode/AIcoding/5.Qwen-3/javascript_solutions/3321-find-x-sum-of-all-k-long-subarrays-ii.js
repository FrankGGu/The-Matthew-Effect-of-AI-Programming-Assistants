function kLongSubarrays(nums, k, x) {
    const n = nums.length;
    let result = 0;

    for (let i = 0; i <= n - k; i++) {
        const subarray = nums.slice(i, i + k);
        const freq = {};
        let sum = 0;

        for (const num of subarray) {
            freq[num] = (freq[num] || 0) + 1;
        }

        const sortedFreq = Object.entries(freq).sort((a, b) => b[1] - a[1]);
        let count = 0;

        for (const [num, freqNum] of sortedFreq) {
            if (count < x) {
                sum += parseInt(num) * Math.min(x - count, freqNum);
                count += freqNum;
            } else {
                break;
            }
        }

        result += sum;
    }

    return result;
}