function numSubarrayProductLessThanK(nums, k) {
    if (k <= 1) return 0;
    let count = 0;
    let left = 0;
    let product = 1;
    for (let right = 0; right < nums.length; right++) {
        product *= nums[right];
        while (product >= k) {
            product /= nums[left];
            left++;
        }
        count += right - left + 1;
    }
    return count;
}