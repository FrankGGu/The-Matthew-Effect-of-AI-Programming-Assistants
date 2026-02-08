function fourSumCount(nums1, nums2, nums3, nums4) {
    const map = new Map();
    let count = 0;

    for (let i = 0; i < nums1.length; i++) {
        for (let j = 0; j < nums2.length; j++) {
            const sum = nums1[i] + nums2[j];
            map.set(sum, (map.get(sum) || 0) + 1);
        }
    }

    for (let k = 0; k < nums3.length; k++) {
        for (let l = 0; l < nums4.length; l++) {
            const target = -(nums3[k] + nums4[l]);
            count += map.get(target) || 0;
        }
    }

    return count;
}