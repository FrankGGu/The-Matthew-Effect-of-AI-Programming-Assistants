function myPow(x, n) {
    if (n === 0) return 1;
    if (n < 0) return 1 / myPow(x, -n);
    if (n % 2 === 0) return myPow(x, n / 2) * myPow(x, n / 2);
    return x * myPow(x, n - 1);
}