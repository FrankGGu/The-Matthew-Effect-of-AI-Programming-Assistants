function maxPoints(points) {
    if (points.length === 0) return 0;
    if (points.length === 1) return points[0][1];

    const n = points.length;
    points.sort((a, b) => a[0] - b[0]);

    const dp = new Array(n).fill(0);
    dp[0] = points[0][1];

    for (let i = 1; i < n; i++) {
        dp[i] = points[i][1];
        for (let j = 0; j < i; j++) {
            if (points[j][0] < points[i][0] && points[j][1] < points[i][1]) {
                dp[i] = Math.max(dp[i], dp[j] + points[i][1]);
            }
        }
    }

    return Math.max(...dp);
}