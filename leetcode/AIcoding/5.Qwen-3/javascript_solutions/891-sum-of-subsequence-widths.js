function sumSubseqWidths(A) {
    A.sort((a, b) => a - b);
    const MOD = 10**9 + 7;
    const n = A.length;
    let result = 0;
    let pow2 = [1];
    for (let i = 1; i < n; i++) {
        pow2.push((pow2[i-1] * 2) % MOD);
    }
    for (let i = 0; i < n; i++) {
        result = (result + A[i] * (pow2[i] - 1) - A[i] * (pow2[n - i - 1] - 1)) % MOD;
    }
    return result;
}