function minimumNumberOfValidStrings(allowed, target) {
    const allowedSet = new Set(allowed);
    const n = target.length;
    const dp = new Array(n + 1).fill(Infinity);
    dp[0] = 0;

    for (let i = 0; i < n; i++) {
        if (dp[i] === Infinity) continue;
        for (let j = i + 1; j <= n; j++) {
            const substr = target.substring(i, j);
            if (allowedSet.has(substr)) {
                dp[j] = Math.min(dp[j], dp[i] + 1);
            }
        }
    }

    return dp[n] === Infinity ? -1 : dp[n];
}