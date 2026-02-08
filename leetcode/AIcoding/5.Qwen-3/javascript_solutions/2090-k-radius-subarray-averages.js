function getAverages(nums, k) {
    const n = nums.length;
    const result = new Array(n).fill(0);
    const prefix = new Array(n + 1).fill(0);

    for (let i = 0; i < n; i++) {
        prefix[i + 1] = prefix[i] + nums[i];
    }

    for (let i = 0; i < n; i++) {
        const left = i - k;
        const right = i + k;
        if (left < 0 || right >= n) {
            result[i] = -1;
        } else {
            const sum = prefix[right + 1] - prefix[left];
            result[i] = sum / (2 * k + 1);
        }
    }

    return result;
}