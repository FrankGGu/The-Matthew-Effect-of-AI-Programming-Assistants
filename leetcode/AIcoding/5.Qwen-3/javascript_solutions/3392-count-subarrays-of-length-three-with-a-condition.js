function goodSubarrays(nums) {
    let count = 0;
    for (let i = 0; i <= nums.length - 3; i++) {
        let a = nums[i];
        let b = nums[i + 1];
        let c = nums[i + 2];
        if (a === b || b === c || a === c) {
            count++;
        }
    }
    return count;
}