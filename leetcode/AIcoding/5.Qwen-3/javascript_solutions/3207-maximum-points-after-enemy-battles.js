function maxPoints(points) {
    const n = points.length;
    if (n === 0) return 0;
    if (n === 1) return points[0];

    const dp = new Array(n).fill(0);
    dp[0] = points[0];
    dp[1] = Math.max(points[0], points[1]);

    for (let i = 2; i < n; i++) {
        dp[i] = Math.max(dp[i - 1], dp[i - 2] + points[i]);
    }

    return dp[n - 1];
}