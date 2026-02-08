function maxPartitions(s, k) {
    const n = s.length;
    const dp = new Array(n + 1).fill(0);
    const last = new Array(26).fill(-1);

    for (let i = 1; i <= n; i++) {
        const c = s[i - 1];
        const idx = c.charCodeAt(0) - 'a'.charCodeAt(0);
        if (last[idx] !== -1) {
            dp[i] = Math.max(dp[i], dp[last[idx]]);
        }
        dp[i] = Math.max(dp[i], dp[i - 1] + 1);
        last[idx] = i - 1;
    }

    return dp[n];
}