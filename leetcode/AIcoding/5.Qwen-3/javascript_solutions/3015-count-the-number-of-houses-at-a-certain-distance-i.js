function numberOfHousesAtDistanceX(n, x) {
    let count = 0;
    for (let i = 1; i <= n; i++) {
        if (Math.abs(i - x) === 1) {
            count++;
        }
    }
    return count;
}