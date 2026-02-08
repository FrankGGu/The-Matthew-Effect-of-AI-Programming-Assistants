function lexSmallestString(s) {
    let stack = [];
    for (let c of s) {
        while (stack.length > 0 && stack[stack.length - 1] > c) {
            stack.pop();
        }
        stack.push(c);
    }
    return stack.join('');
}