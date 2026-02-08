function canWinDigitGame(num) {
    const n = num.length;
    for (let i = 0; i < n - 1; i++) {
        if (num[i] < num[i + 1]) {
            return true;
        }
    }
    return false;
}