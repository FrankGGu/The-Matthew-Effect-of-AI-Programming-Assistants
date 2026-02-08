var smallestNumber = function(num) {
    if (num === "0") return 0;

    let digits = num.split('').map(Number);
    let isNegative = num[0] === '-';

    if (isNegative) {
        digits = digits.slice(1);
        digits.sort((a, b) => b - a);
        let result = parseInt(digits.join(''));
        return -result;
    } else {
        digits.sort((a, b) => a - b);
        let leadingZeros = 0;
        for (let i = 0; i < digits.length; i++) {
            if (digits[i] === 0) {
                leadingZeros++;
            } else {
                break;
            }
        }
        if (leadingZeros > 0) {
            let firstNonZero = digits[leadingZeros];
            digits[leadingZeros] = digits[0];
            digits[0] = firstNonZero;
        }
        return parseInt(digits.join(''));
    }
};