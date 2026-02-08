function countFertilePyramids(park) {
    const m = park.length;
    const n = park[0].length;
    const dp = Array.from({ length: m }, () => Array(n).fill(0));
    let result = 0;

    for (let i = 0; i < m; i++) {
        for (let j = 0; j < n; j++) {
            if (park[i][j] === '1') {
                dp[i][j] = 1;
                if (i > 0 && j > 0 && i < m - 1 && j < n - 1) {
                    dp[i][j] = Math.min(dp[i - 1][j - 1], dp[i - 1][j + 1], dp[i + 1][j]) + 1;
                }
                result += dp[i][j] - 1;
            }
        }
    }

    return result;
}