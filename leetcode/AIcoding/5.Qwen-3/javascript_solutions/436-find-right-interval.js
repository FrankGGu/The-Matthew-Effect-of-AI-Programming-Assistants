function findRightInterval(nums) {
    const n = nums.length;
    const intervals = [];
    for (let i = 0; i < n; i++) {
        intervals.push([nums[i][0], nums[i][1], i]);
    }
    intervals.sort((a, b) => a[0] - b[0]);
    const result = new Array(n).fill(0);
    for (let i = 0; i < n; i++) {
        const [start, end, index] = nums[i];
        let left = 0, right = n - 1;
        let res = -1;
        while (left <= right) {
            const mid = Math.floor((left + right) / 2);
            if (intervals[mid][0] >= start) {
                res = intervals[mid][2];
                right = mid - 1;
            } else {
                left = mid + 1;
            }
        }
        result[index] = res;
    }
    return result;
}