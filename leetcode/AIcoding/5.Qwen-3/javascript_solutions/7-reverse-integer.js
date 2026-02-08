function reverseInteger(x) {
    const sign = Math.sign(x);
    const reversed = parseInt(Math.abs(x).toString().split('').reverse().join(''), 10);
    return reversed * sign;
}