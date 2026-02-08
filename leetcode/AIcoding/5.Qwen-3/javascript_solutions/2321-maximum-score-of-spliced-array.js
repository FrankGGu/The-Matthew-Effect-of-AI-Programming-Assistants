function maxScore(nums1, nums2) {
    const n = nums1.length;
    const pairs = new Array(n).fill(0).map((_, i) => [nums1[i], nums2[i]]);
    pairs.sort((a, b) => a[1] - b[1]);

    let sum1 = 0, sum2 = 0;
    for (let i = 0; i < n; i++) {
        sum1 += pairs[i][0];
        sum2 += pairs[i][1];
    }

    let maxScore = sum1;
    let currentDiff = 0;

    for (let i = 0; i < n; i++) {
        currentDiff += pairs[i][0] - pairs[i][1];
        if (currentDiff < 0) currentDiff = 0;
        maxScore = Math.max(maxScore, sum1 + currentDiff);
    }

    return maxScore;
}