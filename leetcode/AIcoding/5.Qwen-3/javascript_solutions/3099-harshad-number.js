function isHarshad(num) {
    if (num === 0) return false;
    let sum = 0;
    let n = num;
    while (n > 0) {
        sum += n % 10;
        n = Math.floor(n / 10);
    }
    return num % sum === 0;
}