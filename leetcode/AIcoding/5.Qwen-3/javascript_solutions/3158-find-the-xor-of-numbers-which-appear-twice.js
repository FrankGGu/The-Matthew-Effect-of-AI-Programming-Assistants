var threeEqualParts = function(nums) {
    let count = 0;
    for (let i = 0; i < nums.length; i++) {
        if (nums[i] === 1) {
            count++;
        }
    }
    if (count % 3 !== 0) {
        return [-1, -1];
    }
    if (count === 0) {
        return [0, 2];
    }
    let k = count / 3;
    let first = -1, second = -1, third = -1;
    let c = 0;
    for (let i = 0; i < nums.length; i++) {
        if (nums[i] === 1) {
            c++;
            if (c === k) {
                first = i;
            } else if (c === 2 * k) {
                second = i;
            } else if (c === 3 * k) {
                third = i;
                break;
            }
        }
    }
    let len = nums.length - third;
    if (first + len > second || second + len > third) {
        return [-1, -1];
    }
    return [first + len, second + len];
};