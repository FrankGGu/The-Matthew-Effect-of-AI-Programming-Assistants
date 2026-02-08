function maxUniquePrimeCount(n) {
    const isPrime = (num) => {
        if (num < 2) return false;
        for (let i = 2; i * i <= num; i++) {
            if (num % i === 0) return false;
        }
        return true;
    };

    const getPrimes = (num) => {
        const primes = [];
        for (let i = 2; i <= num; i++) {
            if (isPrime(i)) primes.push(i);
        }
        return primes;
    };

    const primes = getPrimes(n);
    let count = 0;
    let sum = 0;

    for (const p of primes) {
        if (sum + p <= n) {
            sum += p;
            count++;
        }
    }

    return count;
}