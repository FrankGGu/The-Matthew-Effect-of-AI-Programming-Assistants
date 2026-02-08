function getNumberOfBacklogOrders(s, m, b, n) {
    const MOD = 1000000007;
    const count = {};
    for (let i = 0; i < s.length; i++) {
        const c = s[i];
        count[c] = (count[c] || 0) + 1;
    }
    let result = 0;
    for (let i = 0; i < b.length; i++) {
        const c = b[i];
        if (count[c] >= n) {
            result++;
            count[c] -= n;
        } else {
            result += Math.floor(count[c] / n);
            count[c] %= n;
        }
    }
    return result % MOD;
}