var bulbSwitcherII = function(n, m) {
    if (m === 0) return n;
    let count = 0;
    for (let i = 1; i <= n; i++) {
        if (i % m === 0) count++;
    }
    return count;
};