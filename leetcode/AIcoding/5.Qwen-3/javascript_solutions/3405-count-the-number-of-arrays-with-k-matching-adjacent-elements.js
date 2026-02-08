function countArrays(n, k) {
    const MOD = 10 ** 9 + 7;
    if (n === 1) return k;
    let dp = new Array(k + 1).fill(0);
    for (let i = 0; i <= k; i++) {
        dp[i] = 1;
    }
    for (let i = 2; i < n; i++) {
        let newDp = new Array(k + 1).fill(0);
        for (let j = 0; j <= k; j++) {
            newDp[j] = (dp[j] * (k - 1)) % MOD;
            if (j > 0) {
                newDp[j] = (newDp[j] + dp[j - 1]) % MOD;
            }
        }
        dp = newDp;
    }
    return dp[k];
}