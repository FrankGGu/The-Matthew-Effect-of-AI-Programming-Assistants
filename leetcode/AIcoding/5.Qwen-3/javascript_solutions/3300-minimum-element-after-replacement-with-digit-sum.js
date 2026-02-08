var sumOfDigits = function(num) {
    let sum = 0;
    while (num > 0) {
        sum += num % 10;
        num = Math.floor(num / 10);
    }
    return sum;
};

var minElement = function(nums) {
    const n = nums.length;
    for (let i = 0; i < n; i++) {
        nums[i] = sumOfDigits(nums[i]);
    }
    return Math.min(...nums);
};