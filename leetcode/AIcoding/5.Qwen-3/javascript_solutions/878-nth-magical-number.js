function nthMagicalNumber(N, K) {
    const MOD = 1e9 + 7;
    let low = 1, high = Math.min(N, K) * N;
    while (low < high) {
        let mid = Math.floor((low + high) / 2);
        let count = 0;
        for (let i = 1; i <= N; i++) {
            count += Math.floor(mid / i);
        }
        if (count < K) {
            low = mid + 1;
        } else {
            high = mid;
        }
    }
    return low % MOD;
}