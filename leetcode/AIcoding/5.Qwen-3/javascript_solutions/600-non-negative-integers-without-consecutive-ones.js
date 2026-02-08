function nonNegativeIntegersWithoutConsecutiveOnes(n) {
    if (n == 0) return 1;
    let a = 1, b = 1;
    for (let i = 2; i <= n; i++) {
        let c = a + b;
        a = b;
        b = c;
    }
    return b;
}