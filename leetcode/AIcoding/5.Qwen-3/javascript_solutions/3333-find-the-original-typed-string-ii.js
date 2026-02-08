var decodeString = function(s) {
    let stack = [];
    let currentNum = 0;
    let currentStr = '';

    for (let char of s) {
        if (char >= '0' && char <= '9') {
            currentNum = currentNum * 10 + parseInt(char);
        } else if (char === '[') {
            stack.push({ str: currentStr, num: currentNum });
            currentStr = '';
            currentNum = 0;
        } else if (char === ']') {
            let { str, num } = stack.pop();
            currentStr = str + currentStr.repeat(num);
        } else {
            currentStr += char;
        }
    }

    return currentStr;
};