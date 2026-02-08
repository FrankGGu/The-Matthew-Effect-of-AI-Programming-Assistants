function mostPoints(questions) {
    const n = questions.length;
    const dp = new Array(n).fill(0);

    for (let i = n - 1; i >= 0; i--) {
        const [points, brainpower] = questions[i];
        if (i + brainpower + 1 < n) {
            dp[i] = Math.max(points + dp[i + brainpower + 1], dp[i + 1]);
        } else {
            dp[i] = Math.max(points, dp[i + 1]);
        }
    }

    return dp[0];
}