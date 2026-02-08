function continuousSubarrays(nums) {
    let count = 0;
    let left = 0;
    let maxVal = nums[0];
    let minVal = nums[0];

    for (let right = 0; right < nums.length; right++) {
        maxVal = Math.max(maxVal, nums[right]);
        minVal = Math.min(minVal, nums[right]);

        while (maxVal - minVal > 2) {
            left++;
            maxVal = Math.max(...nums.slice(left, right + 1));
            minVal = Math.min(...nums.slice(left, right + 1));
        }

        count += right - left + 1;
    }

    return count;
}