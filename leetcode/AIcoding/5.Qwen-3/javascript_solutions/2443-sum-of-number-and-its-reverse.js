function sumOfNumberAndReverse(num) {
    let reverse = 0;
    let n = num;
    while (n > 0) {
        reverse = reverse * 10 + n % 10;
        n = Math.floor(n / 10);
    }
    return num + reverse;
}