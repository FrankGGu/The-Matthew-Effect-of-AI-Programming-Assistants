function maximumOr(nums) {
    const n = nums.length;
    const prefix = new Array(n).fill(0);
    const suffix = new Array(n).fill(0);

    prefix[0] = nums[0];
    for (let i = 1; i < n; i++) {
        prefix[i] = prefix[i - 1] | nums[i];
    }

    suffix[n - 1] = nums[n - 1];
    for (let i = n - 2; i >= 0; i--) {
        suffix[i] = suffix[i + 1] | nums[i];
    }

    let maxOr = 0;
    for (let i = 0; i < n; i++) {
        let left = i > 0 ? prefix[i - 1] : 0;
        let right = i < n - 1 ? suffix[i + 1] : 0;
        maxOr = Math.max(maxOr, left | right);
    }

    return maxOr;
}