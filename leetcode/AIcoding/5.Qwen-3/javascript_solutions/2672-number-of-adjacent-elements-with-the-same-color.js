function numberOfAdjacentElementsWithTheSameColor(n, redBlue) {
    let count = 0;
    for (let i = 1; i < n; i++) {
        if (redBlue[i] === redBlue[i - 1]) {
            count++;
        }
    }
    return count;
}