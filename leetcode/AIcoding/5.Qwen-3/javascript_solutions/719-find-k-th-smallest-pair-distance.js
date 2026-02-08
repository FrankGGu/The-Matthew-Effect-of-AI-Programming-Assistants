function smallestDistancePair(nums, k) {
    nums.sort((a, b) => a - b);
    let left = 0;
    let right = nums[nums.length - 1] - nums[0];

    while (left < right) {
        let mid = left + Math.floor((right - left) / 2);
        let count = 0;
        let j = 0;

        for (let i = 0; i < nums.length; i++) {
            while (j < nums.length && nums[j] - nums[i] <= mid) {
                j++;
            }
            count += j - i - 1;
        }

        if (count >= k) {
            right = mid;
        } else {
            left = mid + 1;
        }
    }

    return left;
}