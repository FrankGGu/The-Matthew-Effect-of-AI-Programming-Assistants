function inventoryManagement(nums, cnt) {
    if (nums.length < 2) return nums[0];
    let left = 0, right = nums.length - 1;
    while (left < right) {
        let pivot = nums[left];
        let i = left, j = right;
        while (i < j) {
            while (i < j && nums[j] >= pivot) j--;
            while (i < j && nums[i] <= pivot) i++;
            if (i < j) {
                let temp = nums[i];
                nums[i] = nums[j];
                nums[j] = temp;
            }
        }
        if (i - left + 1 === cnt) return nums[i];
        else if (i - left + 1 < cnt) {
            left = i + 1;
        } else {
            right = i - 1;
        }
    }
    return nums[left];
}