function numDupDigitsAtMostNGivenDigitSet(S, N) {
    const digits = N.toString().split('').map(c => parseInt(c));
    const len = digits.length;
    const dp = Array(len + 1).fill(0).map(() => Array(2).fill(0));
    dp[0][1] = 1;

    for (let i = 1; i <= len; i++) {
        for (let j = 0; j < 10; j++) {
            if (j === digits[i - 1]) {
                dp[i][1] += dp[i - 1][1];
            } else if (j < digits[i - 1]) {
                dp[i][0] += dp[i - 1][1];
            }
        }

        for (let j = 0; j < S.length; j++) {
            if (S[j] === digits[i - 1]) {
                dp[i][1] += dp[i - 1][1];
            } else if (S[j] < digits[i - 1]) {
                dp[i][0] += dp[i - 1][1];
            }
        }

        for (let j = 0; j < 10; j++) {
            if (j < digits[i - 1]) {
                dp[i][0] += dp[i - 1][0];
            }
        }

        for (let j = 0; j < S.length; j++) {
            if (S[j] < digits[i - 1]) {
                dp[i][0] += dp[i - 1][0];
            }
        }
    }

    return dp[len][0] + dp[len][1];
}