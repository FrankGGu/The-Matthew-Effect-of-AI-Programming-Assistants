function countSubarrays(nums, k) {
    let count = 0;
    let left = 0;
    let minCount = 0;
    let maxCount = 0;
    const freq = {};

    for (let right = 0; right < nums.length; right++) {
        const num = nums[right];
        freq[num] = (freq[num] || 0) + 1;

        if (num === k) {
            minCount++;
            maxCount++;
        } else if (num < k) {
            minCount++;
        } else {
            maxCount++;
        }

        while (minCount > 0 && maxCount > 0) {
            const leftNum = nums[left];
            if (leftNum === k) {
                minCount--;
                maxCount--;
            } else if (leftNum < k) {
                minCount--;
            } else {
                maxCount--;
            }
            left++;
        }

        count += left;
    }

    return count;
}