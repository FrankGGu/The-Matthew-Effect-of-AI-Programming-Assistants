var buyChocolates = function(prices) {
    prices.sort((a, b) => a - b);
    return prices[0] + prices[1];
};