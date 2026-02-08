function numOfSubarrays(m, n) {
    const MOD = 1000000007;
    let dp = new Array(n).fill(0);
    for (let i = 0; i < m; i++) {
        let nextDp = new Array(n).fill(0);
        for (let j = 0; j < n; j++) {
            if (i === 0 && j === 0) {
                nextDp[j] = 1;
            } else {
                let sum = 0;
                if (j > 0) sum += dp[j - 1];
                if (i > 0) sum += dp[j];
                nextDp[j] = sum % MOD;
            }
        }
        dp = nextDp;
    }
    return dp[n - 1] % MOD;
}