function countCollisions(s) {
    let stack = [];
    for (let c of s) {
        if (stack.length === 0) {
            stack.push(c);
        } else {
            let last = stack[stack.length - 1];
            if (last === 'R' && c === 'L') {
                stack.pop();
                stack.push('S');
                while (stack.length > 0 && stack[stack.length - 1] === 'R') {
                    stack.pop();
                    stack.push('S');
                }
            } else if (last === 'S' && c === 'L') {
                stack.push('S');
            } else {
                stack.push(c);
            }
        }
    }
    let count = 0;
    for (let c of stack) {
        if (c === 'S') count++;
    }
    return count;
}