function findNumbers(nums) {
    let count = 0;
    for (let i = 0; i < nums.length; i++) {
        let digits = 0;
        let num = nums[i];
        while (num > 0) {
            digits++;
            num = Math.floor(num / 10);
        }
        if (digits % 2 === 0) {
            count++;
        }
    }
    return count;
}