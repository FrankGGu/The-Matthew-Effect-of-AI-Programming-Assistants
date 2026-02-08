function numSlices(nums, i, j) {
    if (j - i < 2) return 0;
    let count = 0;
    while (j < nums.length) {
        if (nums[j] - nums[j-1] === nums[i+1] - nums[i]) {
            count++;
            j++;
        } else {
            break;
        }
    }
    return count;
}

function numberOfArithmeticSlices(nums) {
    let total = 0;
    for (let i = 0; i < nums.length - 1; i++) {
        for (let j = i + 2; j < nums.length; j++) {
            if (nums[j] - nums[j-1] === nums[i+1] - nums[i]) {
                total += numSlices(nums, i, j);
            } else {
                break;
            }
        }
    }
    return total;
}