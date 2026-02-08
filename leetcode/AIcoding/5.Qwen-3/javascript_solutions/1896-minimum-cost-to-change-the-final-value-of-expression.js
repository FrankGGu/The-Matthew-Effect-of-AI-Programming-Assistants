function minCost(expression) {
    const ops = [];
    const vals = [];

    function evaluate() {
        const op = ops.pop();
        const b = vals.pop();
        const a = vals.pop();
        let res;
        if (op === '+') {
            res = a + b;
        } else {
            res = a * b;
        }
        vals.push(res);
    }

    let i = 0;
    while (i < expression.length) {
        const c = expression[i];
        if (c === ' ') {
            i++;
            continue;
        }
        if (c === '+' || c === '*') {
            while (ops.length && ops[ops.length - 1] !== '(') {
                evaluate();
            }
            ops.push(c);
            i++;
        } else if (c === '(') {
            ops.push(c);
            i++;
        } else if (c === ')') {
            while (ops[ops.length - 1] !== '(') {
                evaluate();
            }
            ops.pop(); // Remove '('
            i++;
        } else {
            let num = 0;
            while (i < expression.length && /[0-9]/.test(expression[i])) {
                num = num * 10 + parseInt(expression[i]);
                i++;
            }
            vals.push(num);
        }
    }

    while (ops.length) {
        evaluate();
    }

    return vals[0];
}