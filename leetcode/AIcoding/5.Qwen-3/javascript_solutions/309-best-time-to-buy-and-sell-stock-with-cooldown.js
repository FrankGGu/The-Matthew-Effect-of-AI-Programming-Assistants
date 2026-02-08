function maxProfit(prices) {
    if (prices.length < 2) return 0;

    let hold = -prices[0];
    let notHold = 0;
    let prevNotHold = 0;

    for (let i = 1; i < prices.length; i++) {
        let temp = notHold;
        notHold = Math.max(notHold, hold + prices[i]);
        hold = Math.max(hold, prevNotHold - prices[i]);
        prevNotHold = temp;
    }

    return notHold;
}