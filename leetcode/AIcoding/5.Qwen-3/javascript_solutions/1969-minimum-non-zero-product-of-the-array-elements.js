function minNonZeroProduct(n, m) {
    const MOD = 10**9 + 7;
    if (m === 1) return 1;
    const maxVal = (1 << n) - 1;
    const power = (a, b) => {
        let result = 1;
        while (b > 0) {
            if (b % 2 === 1) result = (result * a) % MOD;
            a = (a * a) % MOD;
            b = Math.floor(b / 2);
        }
        return result;
    };
    return power(maxVal - 1, m - 1) * maxVal % MOD;
}