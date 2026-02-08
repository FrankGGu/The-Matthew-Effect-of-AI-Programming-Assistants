function numOfSubarrays(nums, k, threshold) {
    let count = 0;
    let sum = 0;
    for (let i = 0; i < k; i++) {
        sum += nums[i];
    }
    if (sum / k >= threshold) count++;
    for (let i = k; i < nums.length; i++) {
        sum += nums[i] - nums[i - k];
        if (sum / k >= threshold) count++;
    }
    return count;
}