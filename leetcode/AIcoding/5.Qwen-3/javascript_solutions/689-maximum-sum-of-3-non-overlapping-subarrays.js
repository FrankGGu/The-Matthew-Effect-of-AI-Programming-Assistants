function maxSumOfThreeSubarrays(nums, k) {
    const n = nums.length;
    const prefix = new Array(n).fill(0);
    prefix[0] = nums[0];
    for (let i = 1; i < n; i++) {
        prefix[i] = prefix[i - 1] + nums[i];
    }

    const sum = (i, j) => prefix[j] - (i > 0 ? prefix[i - 1] : 0);

    const left = new Array(n).fill(0);
    let maxIdx = 0;
    for (let i = k - 1; i < n; i++) {
        if (sum(i - k + 1, i) > sum(maxIdx, maxIdx + k - 1)) {
            maxIdx = i - k + 1;
        }
        left[i] = maxIdx;
    }

    const right = new Array(n).fill(0);
    maxIdx = n - k;
    for (let i = n - k; i >= 0; i--) {
        if (sum(i, i + k - 1) > sum(maxIdx, maxIdx + k - 1)) {
            maxIdx = i;
        }
        right[i] = maxIdx;
    }

    let maxTotal = 0;
    let result = [0, 0, 0];

    for (let i = k; i <= n - k * 2; i++) {
        const leftIdx = left[i - 1];
        const rightIdx = right[i + k];
        const total = sum(leftIdx, leftIdx + k - 1) + sum(i, i + k - 1) + sum(rightIdx, rightIdx + k - 1);
        if (total > maxTotal) {
            maxTotal = total;
            result = [leftIdx, i, rightIdx];
        }
    }

    return result;
}