function isUgly(num) {
    if (num <= 0) return false;
    const factors = [2, 3, 5];
    for (let i = 0; i < factors.length; i++) {
        while (num % factors[i] === 0) {
            num /= factors[i];
        }
    }
    return num === 1;
}