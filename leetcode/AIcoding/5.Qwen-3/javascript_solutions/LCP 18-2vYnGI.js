function breakfastNumber(cakeNumbers, money) {
    let min = Infinity;
    for (let i = 0; i < cakeNumbers.length; i++) {
        for (let j = i; j < cakeNumbers.length; j++) {
            if (cakeNumbers[i] + cakeNumbers[j] <= money) {
                min = Math.min(min, cakeNumbers[i] + cakeNumbers[j]);
            }
        }
    }
    return min === Infinity ? 0 : min;
}