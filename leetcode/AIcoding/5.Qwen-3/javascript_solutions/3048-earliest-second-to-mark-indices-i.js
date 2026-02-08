function earliestSecond(nums) {
    let count = 0;
    let max = 0;
    let result = 0;

    for (let i = 0; i < nums.length; i++) {
        if (nums[i] === 1) {
            count++;
            if (count > max) {
                max = count;
                result = i;
            }
        } else {
            count = 0;
        }
    }

    return result;
}