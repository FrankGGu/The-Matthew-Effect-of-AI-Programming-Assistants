function new21Game(n, k, maxPts) {
    if (k === 0) return 1;
    const dp = new Array(n + 1).fill(0);
    dp[0] = 1;
    let windowSum = 1;
    for (let i = 1; i <= n; i++) {
        dp[i] = windowSum;
        if (i < k) {
            windowSum += dp[i];
        }
        if (i - maxPts >= 0) {
            windowSum -= dp[i - maxPts];
        }
    }
    let result = 0;
    for (let i = k; i <= n; i++) {
        result += dp[i];
    }
    return result;
}