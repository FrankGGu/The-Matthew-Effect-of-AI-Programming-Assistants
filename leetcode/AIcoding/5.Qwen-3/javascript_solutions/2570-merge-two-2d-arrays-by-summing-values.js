function mergeArrays(nums1, nums2) {
    const map = new Map();

    for (const [id, val] of nums1) {
        map.set(id, (map.get(id) || 0) + val);
    }

    for (const [id, val] of nums2) {
        map.set(id, (map.get(id) || 0) + val);
    }

    return Array.from(map.entries()).sort((a, b) => a[0] - b[0]);
}