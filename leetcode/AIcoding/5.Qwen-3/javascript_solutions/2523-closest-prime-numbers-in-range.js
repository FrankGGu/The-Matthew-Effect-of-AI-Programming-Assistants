function closestPrimes(left, right) {
    function isPrime(n) {
        if (n < 2) return false;
        for (let i = 2; i * i <= n; i++) {
            if (n % i === 0) return false;
        }
        return true;
    }

    let prev = -1;
    let minDiff = Infinity;
    let result = [-1, -1];

    for (let i = left; i <= right; i++) {
        if (isPrime(i)) {
            if (prev !== -1 && i - prev < minDiff) {
                minDiff = i - prev;
                result = [prev, i];
            }
            prev = i;
        }
    }

    return result[0] === -1 ? [-1, -1] : result;
}