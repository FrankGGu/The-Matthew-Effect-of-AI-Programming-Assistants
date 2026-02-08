function maxIncreasingGroups(rectangles) {
    rectangles.sort((a, b) => a[0] - b[0] || a[1] - b[1]);
    const dp = [];
    for (const [x, y] of rectangles) {
        let left = 0, right = dp.length;
        while (left < right) {
            const mid = (left + right) >> 1;
            if (dp[mid] < x) left = mid + 1;
            else right = mid;
        }
        if (left === dp.length) dp.push(y);
        else dp[left] = Math.min(dp[left], y);
    }
    return dp.length;
}