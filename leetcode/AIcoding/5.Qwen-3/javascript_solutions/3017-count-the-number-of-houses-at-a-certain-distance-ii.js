function numberOfHousesAtDistanceX(n, x) {
    let count = 0;
    for (let i = 1; i <= n; i++) {
        for (let j = i + 1; j <= n; j++) {
            if (Math.abs(i - j) === x) {
                count++;
            }
        }
    }
    return count;
}