function idealArrays(n) {
    const MOD = 10 ** 9 + 7;
    const max = n;
    const dp = new Array(max + 1).fill(0);
    dp[1] = 1;

    for (let i = 2; i <= max; i++) {
        for (let j = i; j <= max; j += i) {
            dp[j] = (dp[j] + dp[i]) % MOD;
        }
    }

    let result = 0;
    for (let i = 1; i <= max; i++) {
        result = (result + dp[i]) % MOD;
    }

    return result;
}