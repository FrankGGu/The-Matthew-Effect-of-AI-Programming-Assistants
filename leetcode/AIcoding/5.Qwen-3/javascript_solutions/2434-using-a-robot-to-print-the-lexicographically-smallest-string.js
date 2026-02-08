function robotWithString(s) {
    const stack = [];
    const result = [];
    const count = new Array(26).fill(0);

    for (const c of s) {
        count[c.charCodeAt(0) - 'a'.charCodeAt(0)]++;
    }

    for (const c of s) {
        count[c.charCodeAt(0) - 'a'.charCodeAt(0)]--;
        while (stack.length > 0 && stack[stack.length - 1] <= c && count[stack[stack.length - 1].charCodeAt(0) - 'a'.charCodeAt(0)] === 0) {
            result.push(stack.pop());
        }
        stack.push(c);
    }

    while (stack.length > 0) {
        result.push(stack.pop());
    }

    return result.join('');
}