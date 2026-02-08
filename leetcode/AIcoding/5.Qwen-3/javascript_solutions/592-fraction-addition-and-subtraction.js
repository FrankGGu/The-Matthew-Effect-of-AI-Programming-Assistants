function fractionAddition(expression) {
    const nums = [];
    const ops = [];
    let i = 0;
    while (i < expression.length) {
        if (expression[i] === '+' || expression[i] === '-') {
            ops.push(expression[i]);
            i++;
        } else {
            let num = '';
            while (i < expression.length && expression[i] !== '+' && expression[i] !== '-') {
                num += expression[i];
                i++;
            }
            nums.push(num);
        }
    }

    let numerator = 0;
    let denominator = 1;

    for (let j = 0; j < nums.length; j++) {
        const [n, d] = nums[j].split('/').map(Number);
        const op = ops[j] || '+';
        if (op === '+') {
            numerator = numerator * d + n * denominator;
        } else {
            numerator = numerator * d - n * denominator;
        }
        denominator = denominator * d;
        const gcd = function(a, b) {
            while (b) {
                const temp = b;
                b = a % b;
                a = temp;
            }
            return a;
        };
        const common = gcd(Math.abs(numerator), Math.abs(denominator));
        numerator /= common;
        denominator /= common;
    }

    return `${numerator}/${denominator}`;
}