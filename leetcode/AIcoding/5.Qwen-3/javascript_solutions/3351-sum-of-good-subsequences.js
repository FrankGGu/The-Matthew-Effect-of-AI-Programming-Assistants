var sumOfGoodSubsequences = function(s) {
    const MOD = 10**9 + 7;
    let dp = new Array(26).fill(0);
    let total = 0;

    for (let i = 0; i < s.length; i++) {
        let c = s[i];
        let idx = c.charCodeAt(0) - 'a'.charCodeAt(0);
        let count = 1;

        for (let j = 0; j < 26; j++) {
            if (j !== idx) {
                count += dp[j];
                count %= MOD;
            }
        }

        dp[idx] = (dp[idx] + count) % MOD;
        total = (total + count) % MOD;
    }

    return total;
};