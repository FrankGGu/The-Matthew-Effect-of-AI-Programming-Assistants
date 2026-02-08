function sumOfPrimeFactors(n) {
    function isPrime(num) {
        if (num < 2) return false;
        for (let i = 2; i * i <= num; i++) {
            if (num % i === 0) return false;
        }
        return true;
    }

    let sum = 0;
    let i = 2;
    while (i * i <= n) {
        while (n % i === 0) {
            sum += i;
            n /= i;
        }
        i++;
    }
    if (n > 1) sum += n;
    return sum;
}

function smallestValue(n) {
    let seen = new Set();
    while (true) {
        if (seen.has(n)) return n;
        seen.add(n);
        n = sumOfPrimeFactors(n);
    }
}