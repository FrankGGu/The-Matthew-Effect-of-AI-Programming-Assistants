function splitNum(num) {
    const digits = num.toString().split('').map(Number);
    digits.sort((a, b) => a - b);
    let a = 0, b = 0;
    for (let i = 0; i < digits.length; i++) {
        if (i % 2 === 0) {
            a = a * 10 + digits[i];
        } else {
            b = b * 10 + digits[i];
        }
    }
    return a + b;
}