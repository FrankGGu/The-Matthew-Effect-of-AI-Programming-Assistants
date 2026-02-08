function superPow(a, b) {
    function modPow(base, exp, mod) {
        let result = 1;
        base = base % mod;
        while (exp > 0) {
            if (exp % 2 === 1) {
                result = (result * base) % mod;
            }
            base = (base * base) % mod;
            exp = Math.floor(exp / 2);
        }
        return result;
    }

    let result = 1;
    for (let i = 0; i < b.length; i++) {
        result = (modPow(result, 10, 1337) * modPow(a, b[i], 1337)) % 1337;
    }
    return result;
}