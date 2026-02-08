function getDescentPeriods(prices) {
    let count = 0;
    let streak = 0;

    for (let i = 1; i < prices.length; i++) {
        if (prices[i - 1] - prices[i] === 1) {
            streak++;
        } else {
            streak = 0;
        }
        count += streak;
    }

    return count + prices.length;
}