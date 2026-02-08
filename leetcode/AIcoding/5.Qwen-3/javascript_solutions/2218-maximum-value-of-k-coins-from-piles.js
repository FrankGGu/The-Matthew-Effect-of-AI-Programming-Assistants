function maxValueOfKCoins(piles, k) {
    const n = piles.length;
    const dp = new Array(k + 1).fill(0);

    for (let i = 0; i < n; i++) {
        const pile = piles[i];
        const m = pile.length;
        const temp = [...dp];

        for (let j = 1; j <= k; j++) {
            let maxVal = 0;
            for (let l = 0; l < Math.min(j, m); l++) {
                maxVal = Math.max(maxVal, pile[l] + (j - l - 1 >= 0 ? dp[j - l - 1] : 0));
            }
            temp[j] = Math.max(temp[j], maxVal);
        }

        for (let j = 0; j <= k; j++) {
            dp[j] = temp[j];
        }
    }

    return dp[k];
}