function minSpaceWastedPrime(packages, boxes) {
    const n = packages.length;
    const m = boxes.length;

    boxes.sort((a, b) => a[0] - b[0] || a[1] - b[1]);

    const dp = new Array(n).fill(0);

    for (let i = 0; i < n; i++) {
        let minWaste = Infinity;
        for (let j = 0; j < m; j++) {
            if (boxes[j][0] >= packages[i]) {
                const waste = boxes[j][1] - packages[i];
                if (i === 0) {
                    dp[i] = waste;
                } else {
                    dp[i] = Math.min(dp[i], dp[i - 1] + waste);
                }
                minWaste = Math.min(minWaste, waste);
            }
        }
        if (minWaste === Infinity) {
            return -1;
        }
    }

    return dp[n - 1];
}