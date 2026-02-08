function calPoints(operations) {
    const stack = [];
    for (const op of operations) {
        if (op === 'C') {
            stack.pop();
        } else if (op === 'D') {
            stack.push(stack[stack.length - 1] * 2);
        } else if (op === '+') {
            stack.push(stack[stack.length - 1] + stack[stack.length - 2]);
        } else {
            stack.push(parseInt(op));
        }
    }
    return stack.reduce((a, b) => a + b, 0);
}