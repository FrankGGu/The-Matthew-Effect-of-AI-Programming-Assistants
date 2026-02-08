function smallestDivisibleDigitProduct(n) {
    if (n === 0) return 0;
    let result = 1;
    for (let i = 9; i >= 2; i--) {
        while (n % i === 0) {
            result *= i;
            n /= i;
        }
    }
    return n === 1 ? result : 0;
}