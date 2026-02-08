function canAliceWin(n) {
    let sum = 0;
    for (let i = 1; i <= n; i++) {
        sum += i;
        if (sum > n) break;
        if (sum === n) return true;
    }
    return false;
}