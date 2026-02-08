function validateBookOrder(putIn, takeOut) {
    const stack = [];
    let index = 0;
    for (let i = 0; i < putIn.length; i++) {
        stack.push(putIn[i]);
        while (stack.length > 0 && stack[stack.length - 1] === takeOut[index]) {
            stack.pop();
            index++;
        }
    }
    return index === takeOut.length;
}