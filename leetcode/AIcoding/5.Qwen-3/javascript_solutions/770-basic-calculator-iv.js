function basicCalculatorIV(expression, evalvars, evalints) {
    const vars = new Map();
    for (let i = 0; i < evalvars.length; ++i) {
        vars.set(evalvars[i], evalints[i]);
    }

    const tokens = tokenize(expression);
    const postfix = toPostfix(tokens);
    const result = evaluate(postfix, vars);
    return result;
}

function tokenize(expression) {
    const tokens = [];
    let i = 0;
    while (i < expression.length) {
        if (expression[i] === ' ') {
            ++i;
        } else if (/[+\-*/()]/.test(expression[i])) {
            tokens.push(expression[i]);
            ++i;
        } else if (/\d/.test(expression[i])) {
            let num = '';
            while (i < expression.length && /\d/.test(expression[i])) {
                num += expression[i];
                ++i;
            }
            tokens.push(num);
        } else if (/[a-z]/.test(expression[i])) {
            let varName = '';
            while (i < expression.length && /[a-z]/.test(expression[i])) {
                varName += expression[i];
                ++i;
            }
            tokens.push(varName);
        } else {
            ++i;
        }
    }
    return tokens;
}

function toPostfix(tokens) {
    const output = [];
    const stack = [];
    const precedence = { '+': 1, '-': 1, '*': 2, '/': 2 };

    for (const token of tokens) {
        if (/^\d+$/.test(token)) {
            output.push(token);
        } else if (/[a-z]/.test(token)) {
            output.push(token);
        } else if (token === '(') {
            stack.push(token);
        } else if (token === ')') {
            while (stack.length && stack[stack.length - 1] !== '(') {
                output.push(stack.pop());
            }
            stack.pop(); // Remove the '('
        } else {
            while (stack.length && stack[stack.length - 1] !== '(' && precedence[stack[stack.length - 1]] >= precedence[token]) {
                output.push(stack.pop());
            }
            stack.push(token);
        }
    }

    while (stack.length) {
        output.push(stack.pop());
    }

    return output;
}

function evaluate(postfix, vars) {
    const stack = [];

    for (const token of postfix) {
        if (/^\d+$/.test(token)) {
            stack.push({ [token]: 1 });
        } else if (/[a-z]/.test(token)) {
            if (vars.has(token)) {
                stack.push({ [token]: 1 });
            } else {
                stack.push({ [token]: 1 });
            }
        } else {
            const right = stack.pop();
            const left = stack.pop();
            const result = {};
            if (token === '+') {
                merge(result, left);
                merge(result, right);
            } else if (token === '-') {
                merge(result, left);
                merge(result, negate(right));
            } else if (token === '*') {
                multiply(result, left, right);
            } else if (token === '/') {
                divide(result, left, right);
            }
            stack.push(result);
        }
    }

    const result = stack[0];
    const keys = Object.keys(result).sort((a, b) => {
        const aParts = a.split('*').filter(p => p !== '');
        const bParts = b.split('*').filter(p => p !== '');
        if (aParts.length !== bParts.length) {
            return aParts.length - bParts.length;
        }
        for (let i = 0; i < aParts.length; ++i) {
            const aPart = aParts[i];
            const bPart = bParts[i];
            if (aPart !== bPart) {
                return aPart.localeCompare(bPart);
            }
        }
        return 0;
    });

    const res = [];
    for (const key of keys) {
        res.push(key);
    }
    return res;
}

function merge(target, source) {
    for (const key in source) {
        if (target[key]) {
            target[key] += source[key];
        } else {
            target[key] = source[key];
        }
    }
}

function negate(obj) {
    const result = {};
    for (const key in obj) {
        result[key] = -obj[key];
    }
    return result;
}

function multiply(target, left, right) {
    for (const lKey in left) {
        for (const rKey in right) {
            const lParts = lKey.split('*').filter(p => p !== '');
            const rParts = rKey.split('*').filter(p => p !== '');
            const combined = [...lParts, ...rParts].sort();
            const combinedKey = combined.join('*');
            if (combinedKey === '') {
                target[''] = (target[''] || 0) + left[lKey] * right[rKey];
            } else {
                target[combinedKey] = (target[combinedKey] || 0) + left[lKey] * right[rKey];
            }
        }
    }
}

function divide(target, left, right) {
    for (const lKey in left) {
        for (const rKey in right) {
            const lParts = lKey.split('*').filter(p => p !== '');
            const rParts = rKey.split('*').filter(p => p !== '');
            const combined = [...lParts, ...rParts].sort();
            const combinedKey = combined.join('*');
            if (combinedKey === '') {
                target[''] = (target[''] || 0) + left[lKey] / right[rKey];
            } else {
                target[combinedKey] = (target[combinedKey] || 0) + left[lKey] / right[rKey];
            }
        }
    }
}