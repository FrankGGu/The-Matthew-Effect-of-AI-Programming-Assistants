function coinBonus(coin) {
    let bonus = 0;
    for (let i = 0; i < coin.length; i++) {
        if (coin[i] === 'C') {
            bonus += 1;
        } else if (coin[i] === 'A') {
            bonus += 2;
        } else if (coin[i] === 'B') {
            bonus += 3;
        }
    }
    return bonus;
}