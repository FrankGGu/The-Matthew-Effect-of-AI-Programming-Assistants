var accountBalanceAfterPurchase = function(purchaseAmount) {
    const amount = parseInt(purchaseAmount);
    const remainder = amount % 10;
    if (remainder < 5) {
        return amount - remainder;
    } else {
        return amount + (10 - remainder);
    }
};