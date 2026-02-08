function pivotInteger(x) {
    const total = x * (x + 1) / 2;
    let prefix = 0;
    for (let i = 1; i <= x; i++) {
        prefix += i;
        if (prefix === total - prefix + i) {
            return i;
        }
    }
    return -1;
}