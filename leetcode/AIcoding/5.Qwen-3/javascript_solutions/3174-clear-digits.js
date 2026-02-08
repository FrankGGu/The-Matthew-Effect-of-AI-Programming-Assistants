function clearDigits(s) {
    const stack = [];
    for (let i = 0; i < s.length; i++) {
        if (s[i] >= '0' && s[i] <= '9') {
            if (stack.length > 0) {
                stack.pop();
            }
        } else {
            stack.push(s[i]);
        }
    }
    return stack.join('');
}