function findTheArrayConcatenationValue(nums) {
    let left = 0;
    let right = nums.length - 1;
    let value = 0;

    while (left <= right) {
        if (left === right) {
            value += nums[left];
        } else {
            value += parseInt(nums[left].toString() + nums[right].toString());
        }
        left++;
        right--;
    }

    return value;
}