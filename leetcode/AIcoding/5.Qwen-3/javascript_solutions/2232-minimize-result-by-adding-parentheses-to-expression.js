function minimizeResult(expression) {
    const [left, right] = expression.split('+');
    let minResult = Infinity;
    let bestParentheses = '';

    for (let i = 0; i < left.length; i++) {
        for (let j = 1; j <= right.length; j++) {
            const leftPart = left.slice(0, i) + '(' + left.slice(i);
            const rightPart = right.slice(0, j) + ')' + right.slice(j);
            const expr = leftPart + '+' + rightPart;
            const result = eval(expr);
            if (result < minResult) {
                minResult = result;
                bestParentheses = expr;
            }
        }
    }

    return bestParentheses;
}