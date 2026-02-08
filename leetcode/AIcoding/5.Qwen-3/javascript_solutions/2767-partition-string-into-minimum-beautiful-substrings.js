function minNumberOfBeautifulSubstrings(s) {
    const n = s.length;
    const dp = new Array(n + 1).fill(Infinity);
    dp[0] = 0;

    for (let i = 1; i <= n; i++) {
        for (let j = 0; j < i; j++) {
            const substr = s.substring(j, i);
            if (isBeautiful(substr)) {
                dp[i] = Math.min(dp[i], dp[j] + 1);
            }
        }
    }

    return dp[n];
}

function isBeautiful(s) {
    const num = parseInt(s, 2);
    const sqrt = Math.sqrt(num);
    return sqrt === Math.floor(sqrt);
}