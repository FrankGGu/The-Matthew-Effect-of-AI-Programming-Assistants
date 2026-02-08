function find132pattern(nums) {
    const stack = [];
    let third = -Infinity;

    for (let i = nums.length - 1; i >= 0; i--) {
        if (nums[i] < third) return true;
        while (stack.length > 0 && nums[i] > stack[stack.length - 1]) {
            third = stack.pop();
        }
        stack.push(nums[i]);
    }

    return false;
}