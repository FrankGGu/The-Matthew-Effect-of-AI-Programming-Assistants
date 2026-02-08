function minReplacementsToSort(nums) {
    let res = 0;
    for (let i = nums.length - 1; i > 0; i--) {
        if (nums[i] >= nums[i - 1]) continue;
        let cnt = 0;
        while (nums[i] < nums[i - 1]) {
            nums[i] = Math.floor(nums[i] / 2);
            cnt++;
        }
        res += cnt;
    }
    return res;
}