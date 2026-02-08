function sumLargestPrimeSubstrings(s) {
    function isPrime(n) {
        if (n < 2) return false;
        for (let i = 2; i * i <= n; i++) {
            if (n % i === 0) return false;
        }
        return true;
    }

    let maxSum = 0;
    const n = s.length;

    for (let i = 0; i < n; i++) {
        for (let j = i + 1; j <= n; j++) {
            const substr = s.substring(i, j);
            const num = parseInt(substr, 10);
            if (isPrime(num)) {
                maxSum += num;
            }
        }
    }

    return maxSum;
}