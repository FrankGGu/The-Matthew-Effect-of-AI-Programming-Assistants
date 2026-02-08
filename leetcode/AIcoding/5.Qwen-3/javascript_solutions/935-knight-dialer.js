var knightDialer = function(n) {
    const MOD = 1000000007;
    const moves = [
        [4, 6],
        [6, 8],
        [7, 9],
        [4, 8],
        [0, 3, 9],
        [],
        [0, 1, 7],
        [2, 6],
        [1, 3],
        [2, 4]
    ];

    let dp = new Array(10).fill(1);

    for (let i = 1; i < n; i++) {
        let nextDp = new Array(10).fill(0);
        for (let j = 0; j <= 9; j++) {
            for (const move of moves[j]) {
                nextDp[move] = (nextDp[move] + dp[j]) % MOD;
            }
        }
        dp = nextDp;
    }

    return dp.reduce((sum, count) => (sum + count) % MOD, 0);
};