function maxPrimeDifference(nums) {
    function isPrime(n) {
        if (n < 2) return false;
        for (let i = 2; i * i <= n; i++) {
            if (n % i === 0) return false;
        }
        return true;
    }

    let minPrime = Infinity;
    let maxPrime = -Infinity;

    for (const num of nums) {
        if (isPrime(num)) {
            if (num < minPrime) minPrime = num;
            if (num > maxPrime) maxPrime = num;
        }
    }

    return maxPrime - minPrime;
}