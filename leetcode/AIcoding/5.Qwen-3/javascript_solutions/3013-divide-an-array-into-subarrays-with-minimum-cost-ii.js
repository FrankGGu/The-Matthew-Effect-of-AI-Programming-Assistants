var sumSubarrayMins = function(nums) {
    const MOD = 10**9 + 7;
    const n = nums.length;
    const left = new Array(n).fill(-1);
    const right = new Array(n).fill(n);
    const stack = [];

    for (let i = 0; i < n; i++) {
        while (stack.length > 0 && nums[stack[stack.length - 1]] > nums[i]) {
            right[stack.pop()] = i;
        }
        if (stack.length > 0) {
            left[i] = stack[stack.length - 1];
        }
        stack.push(i);
    }

    stack.length = 0;

    for (let i = n - 1; i >= 0; i--) {
        while (stack.length > 0 && nums[stack[stack.length - 1]] >= nums[i]) {
            left[stack.pop()] = i;
        }
        if (stack.length > 0) {
            right[i] = stack[stack.length - 1];
        }
        stack.push(i);
    }

    let result = 0;
    for (let i = 0; i < n; i++) {
        result += nums[i] * (i - left[i]) * (right[i] - i);
        result %= MOD;
    }

    return result;
};