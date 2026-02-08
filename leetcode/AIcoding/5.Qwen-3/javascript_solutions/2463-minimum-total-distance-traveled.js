function minimumTotalDistance(robot, factory) {
    robot.sort((a, b) => a - b);
    factory.sort((a, b) => a[0] - b[0]);

    const n = robot.length;
    const m = factory.length;

    const dp = new Array(n).fill(0).map(() => new Array(m).fill(0));

    for (let i = 0; i < n; i++) {
        for (let j = 0; j < m; j++) {
            if (i === 0) {
                dp[i][j] = Math.abs(robot[i] - factory[j][0]);
            } else {
                dp[i][j] = Math.abs(robot[i] - factory[j][0]) + dp[i - 1][j];
            }
        }
    }

    for (let i = 0; i < n; i++) {
        for (let j = 1; j < m; j++) {
            dp[i][j] = Math.min(dp[i][j], dp[i][j - 1]);
        }
    }

    for (let i = 1; i < n; i++) {
        for (let j = 0; j < m; j++) {
            for (let k = 0; k < j; k++) {
                if (factory[k][1] > 0) {
                    dp[i][j] = Math.min(dp[i][j], dp[i - 1][k] + Math.abs(robot[i] - factory[j][0]));
                }
            }
        }
    }

    return dp[n - 1][m - 1];
}