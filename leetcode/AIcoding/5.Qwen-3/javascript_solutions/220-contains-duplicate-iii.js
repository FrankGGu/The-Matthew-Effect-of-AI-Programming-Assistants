function containsNearbyAlmostDuplicate(nums, k, t) {
    if (t < 0 || k < 0) return false;
    const map = {};
    const bucketSize = t + 1;
    for (let i = 0; i < nums.length; i++) {
        const num = nums[i];
        const bucketId = Math.floor(num / bucketSize);
        if (map.hasOwnProperty(bucketId)) return true;
        if (map.hasOwnProperty(bucketId - 1) && Math.abs(num - map[bucketId - 1]) <= t) return true;
        if (map.hasOwnProperty(bucketId + 1) && Math.abs(num - map[bucketId + 1]) <= t) return true;
        map[bucketId] = num;
        if (i >= k) delete map[Math.floor(nums[i - k] / bucketSize)];
    }
    return false;
}