function countBeautifulSplits(nums) {
    const n = nums.length;
    let count = 0;

    for (let i = 1; i < n - 1; i++) {
        let left = new Set();
        let right = new Set();

        for (let j = 0; j < i; j++) {
            left.add(nums[j]);
        }

        for (let j = i + 1; j < n; j++) {
            right.add(nums[j]);
        }

        if (left.size === right.size) {
            count++;
        }
    }

    return count;
}