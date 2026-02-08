function maxDistance(nums1, nums2) {
    let maxDist = 0;
    let i = 0;
    let j = 1;
    while (i < nums1.length && j < nums2.length) {
        if (nums1[i] <= nums2[j]) {
            maxDist = Math.max(maxDist, j - i);
            j++;
        } else {
            i++;
        }
    }
    return maxDist;
}