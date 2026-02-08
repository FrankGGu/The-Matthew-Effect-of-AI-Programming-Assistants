function countGoodStrings(maxLength, numDifferentChars) {
    const MOD = 1000000007;
    let dp = new Array(maxLength + 1).fill(0);
    dp[0] = 1;

    for (let i = 1; i <= maxLength; i++) {
        dp[i] = (dp[i - 1] * numDifferentChars) % MOD;
    }

    let result = 0;
    for (let i = 1; i <= maxLength; i++) {
        result = (result + dp[i]) % MOD;
    }

    return result;
}