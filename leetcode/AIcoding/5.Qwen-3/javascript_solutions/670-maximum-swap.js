function maximumSwap(num) {
    const digits = num.toString().split('');
    const lastIndices = {};

    for (let i = 0; i < digits.length; i++) {
        lastIndices[digits[i]] = i;
    }

    for (let i = 0; i < digits.length; i++) {
        const currentDigit = digits[i];
        for (let d = 9; d > parseInt(currentDigit); d--) {
            const digitStr = d.toString();
            if (lastIndices[digitStr] && lastIndices[digitStr] > i) {
                [digits[i], digits[lastIndices[digitStr]]] = [digits[lastIndices[digitStr]], digits[i]];
                return parseInt(digits.join(''));
            }
        }
    }

    return num;
}