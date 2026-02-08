function minCount(coins) {
    let count = 0;
    for (let i = 0; i < coins.length; i++) {
        count += Math.floor(coins[i] / 2);
    }
    return count;
}