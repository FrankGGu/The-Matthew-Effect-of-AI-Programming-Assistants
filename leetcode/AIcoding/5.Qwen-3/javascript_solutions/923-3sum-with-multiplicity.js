function threeSumMulti(nums, target) {
    nums.sort((a, b) => a - b);
    const n = nums.length;
    let count = 0;

    for (let i = 0; i < n - 2; i++) {
        if (i > 0 && nums[i] === nums[i - 1] && i > 0) continue;
        let left = i + 1;
        let right = n - 1;
        while (left < right) {
            const sum = nums[i] + nums[left] + nums[right];
            if (sum === target) {
                if (nums[left] === nums[right]) {
                    const total = right - left + 1;
                    count += total * (total - 1) / 2;
                    break;
                } else {
                    let leftCount = 1;
                    let rightCount = 1;
                    while (left + 1 < right && nums[left] === nums[left + 1]) {
                        left++;
                        leftCount++;
                    }
                    while (right - 1 > left && nums[right] === nums[right - 1]) {
                        right--;
                        rightCount++;
                    }
                    count += leftCount * rightCount;
                    left++;
                    right--;
                }
            } else if (sum < target) {
                left++;
            } else {
                right--;
            }
        }
    }

    return count;
}