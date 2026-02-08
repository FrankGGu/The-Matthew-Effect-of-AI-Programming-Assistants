function missingInteger(nums) {
    let prefix = nums[0];
    for (let i = 1; i < nums.length; i++) {
        if (nums[i] === prefix + 1) {
            prefix = nums[i];
        } else {
            break;
        }
    }
    while (true) {
        if (!nums.includes(prefix)) {
            return prefix;
        }
        prefix++;
    }
}