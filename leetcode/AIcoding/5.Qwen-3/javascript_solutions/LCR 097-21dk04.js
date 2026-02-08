function distinctSubseqII(s) {
    const MOD = 1000000007;
    const dp = new Array(s.length + 1).fill(0);
    dp[0] = 1;
    const last = new Map();

    for (let i = 1; i <= s.length; i++) {
        dp[i] = (dp[i - 1] * 2) % MOD;
        if (last.has(s[i - 1])) {
            dp[i] = (dp[i] - dp[last.get(s[i - 1]) - 1] + MOD) % MOD;
        }
        last.set(s[i - 1], i);
    }

    return dp[s.length];
}