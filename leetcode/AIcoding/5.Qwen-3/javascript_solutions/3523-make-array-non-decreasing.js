function arrayChange(nums, operations) {
    const map = new Map();
    for (let i = 0; i < nums.length; i++) {
        map.set(nums[i], i);
    }
    for (const [oldVal, newVal] of operations) {
        const index = map.get(oldVal);
        nums[index] = newVal;
        map.set(newVal, index);
        map.delete(oldVal);
    }
    return nums;
}