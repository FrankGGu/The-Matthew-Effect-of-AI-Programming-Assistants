function nthSuperUglyNumber(n, primes) {
    const ugly = new Array(n).fill(1);
    const pointers = new Array(primes.length).fill(0);
    const next = new Array(primes.length).fill(1);

    for (let i = 1; i < n; i++) {
        let minNext = Infinity;
        for (let j = 0; j < primes.length; j++) {
            if (next[j] < minNext) {
                minNext = next[j];
            }
        }
        ugly[i] = minNext;
        for (let j = 0; j < primes.length; j++) {
            if (next[j] === minNext) {
                pointers[j]++;
                next[j] = ugly[pointers[j]] * primes[j];
            }
        }
    }
    return ugly[n - 1];
}