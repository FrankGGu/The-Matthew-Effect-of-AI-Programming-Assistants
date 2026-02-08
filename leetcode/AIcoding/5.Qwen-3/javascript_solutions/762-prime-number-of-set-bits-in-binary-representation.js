function countPrimeSetBits(left, right) {
    function isPrime(n) {
        if (n < 2) return false;
        for (let i = 2; i * i <= n; i++) {
            if (n % i === 0) return false;
        }
        return true;
    }

    let count = 0;
    for (let i = left; i <= right; i++) {
        let bits = 0;
        let num = i;
        while (num > 0) {
            bits += num & 1;
            num >>= 1;
        }
        if (isPrime(bits)) count++;
    }
    return count;
}