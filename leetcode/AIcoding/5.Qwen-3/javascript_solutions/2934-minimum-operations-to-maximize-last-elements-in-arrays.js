function minOperations(nums1, nums2) {
    const n = nums1.length;
    let ops = 0;
    for (let i = n - 1; i > 0; i--) {
        if (nums1[i] >= nums2[i]) continue;
        let temp = nums1[i];
        nums1[i] = nums2[i];
        nums2[i] = temp;
        ops++;
    }
    for (let i = n - 1; i > 0; i--) {
        if (nums1[i] >= nums2[i]) continue;
        let temp = nums1[i];
        nums1[i] = nums2[i];
        nums2[i] = temp;
        ops++;
    }
    return ops;
}