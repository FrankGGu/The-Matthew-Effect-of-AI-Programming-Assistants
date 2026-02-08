function minimumMoney(prices) {
    let total = 0;
    let maxDiff = 0;
    for (let i = 0; i < prices.length; i++) {
        let diff = prices[i] - prices[i + 1];
        if (i < prices.length - 1) {
            if (diff > 0) {
                total += prices[i] - prices[i + 1];
            } else {
                maxDiff = Math.max(maxDiff, prices[i + 1] - prices[i]);
            }
        } else {
            maxDiff = Math.max(maxDiff, prices[i]);
        }
    }
    return total + maxDiff;
}