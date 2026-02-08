function longestEqualSubarray(nums, k) {
    const map = new Map();
    let maxLen = 0;
    let left = 0;

    for (let right = 0; right < nums.length; right++) {
        const num = nums[right];
        map.set(num, (map.get(num) || 0) + 1);

        while (map.get(num) - (map.get(nums[left]) || 0) > k) {
            map.set(nums[left], map.get(nums[left]) - 1);
            if (map.get(nums[left]) === 0) {
                map.delete(nums[left]);
            }
            left++;
        }

        maxLen = Math.max(maxLen, right - left + 1);
    }

    return maxLen;
}