function removeKDigits(num, k) {
    const stack = [];
    for (let i = 0; i < num.length; i++) {
        while (k > 0 && stack.length > 0 && stack[stack.length - 1] > num[i]) {
            stack.pop();
            k--;
        }
        stack.push(num[i]);
    }
    while (k > 0) {
        stack.pop();
        k--;
    }
    let result = stack.join('').replace(/^0+/, '');
    return result === '' ? '0' : result;
}