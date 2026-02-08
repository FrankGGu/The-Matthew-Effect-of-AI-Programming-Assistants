function maximizeWin(nums, k) {
    const n = nums.length;
    const left = new Array(n).fill(0);
    const right = new Array(n).fill(0);

    let maxLen = 0;
    let start = 0;

    for (let i = 0; i < n; i++) {
        while (nums[i] - nums[start] > k) {
            start++;
        }
        maxLen = Math.max(maxLen, i - start + 1);
        left[i] = maxLen;
    }

    maxLen = 0;
    start = n - 1;

    for (let i = n - 1; i >= 0; i--) {
        while (nums[i] - nums[start] > k) {
            start--;
        }
        maxLen = Math.max(maxLen, start - i + 1);
        right[i] = maxLen;
    }

    let result = 0;

    for (let i = 0; i < n; i++) {
        if (i + 1 < n) {
            result = Math.max(result, left[i] + right[i + 1]);
        } else {
            result = Math.max(result, left[i]);
        }
    }

    return result;
}