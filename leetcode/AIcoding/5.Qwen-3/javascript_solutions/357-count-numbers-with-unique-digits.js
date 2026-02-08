function countNumbersWithUniqueDigits(n) {
    if (n === 0) return 1;
    if (n >= 10) n = 10;
    let total = 10;
    let unique = 9;
    for (let i = 1; i < n; i++) {
        unique *= (10 - i);
        total += unique;
    }
    return total;
}