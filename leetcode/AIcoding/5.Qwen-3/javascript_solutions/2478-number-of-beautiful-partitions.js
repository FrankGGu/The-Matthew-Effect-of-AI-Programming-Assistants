function numberOfBeautifulPartitions(s, k) {
    const MOD = 1000000007;
    const n = s.length;
    if (k === 0) return 1;
    if (n < k) return 0;

    const isVowel = (c) => ['a', 'e', 'i', 'o', 'u'].includes(c);

    const dp = Array.from({ length: n + 1 }, () => Array(k + 1).fill(0));
    dp[0][0] = 1;

    for (let i = 1; i <= n; i++) {
        for (let j = 1; j <= k; j++) {
            for (let m = 0; m < i; m++) {
                if (isVowel(s[m]) && !isVowel(s[i - 1])) {
                    dp[i][j] = (dp[i][j] + dp[m][j - 1]) % MOD;
                }
            }
        }
    }

    return dp[n][k];
}