function minCostToMakeArraysIdentical(nums1, nums2, cost1, cost2) {
    const map = new Map();
    for (let i = 0; i < nums1.length; i++) {
        const key = nums1[i];
        if (!map.has(key)) {
            map.set(key, [0, 0]);
        }
        map.get(key)[0] += cost1[i];
    }
    for (let i = 0; i < nums2.length; i++) {
        const key = nums2[i];
        if (!map.has(key)) {
            map.set(key, [0, 0]);
        }
        map.get(key)[1] += cost2[i];
    }

    let total = 0;
    for (const [a, b] of map.values()) {
        if (a !== b) {
            return -1;
        }
        total += a;
    }
    return total;
}