function calculateCashback(price, cashbackRate) {
    return Math.floor(price * cashbackRate);
}

function calculateTotalPrice(prices, special, needs) {
    let total = 0;
    for (let i = 0; i < prices.length; i++) {
        total += prices[i] * needs[i];
    }
    return total;
}

function findMinPrice(prices, special, needs, memo) {
    const key = needs.join(',');
    if (memo.has(key)) {
        return memo.get(key);
    }

    let minPrice = calculateTotalPrice(prices, special, needs);

    for (let i = 0; i < special.length; i++) {
        let canApply = true;
        for (let j = 0; j < needs.length; j++) {
            if (needs[j] < special[i][j]) {
                canApply = false;
                break;
            }
        }
        if (canApply) {
            let newNeeds = [...needs];
            for (let j = 0; j < needs.length; j++) {
                newNeeds[j] -= special[i][j];
            }
            let priceWithOffer = special[i][special[i].length - 1] + findMinPrice(prices, special, newNeeds, memo);
            minPrice = Math.min(minPrice, priceWithOffer);
        }
    }

    memo.set(key, minPrice);
    return minPrice;
}

function shoppingOffers(price, special, needs) {
    const memo = new Map();
    return findMinPrice(price, special, needs, memo);
}