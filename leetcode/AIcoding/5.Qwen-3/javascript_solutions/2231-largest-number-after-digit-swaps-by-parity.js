function largestNumber(num) {
    const digits = num.toString().split('').map(Number);
    const parityMap = {};
    for (let i = 0; i < digits.length; i++) {
        const key = digits[i] % 2;
        if (!parityMap[key]) {
            parityMap[key] = [];
        }
        parityMap[key].push(i);
    }
    for (let i = 0; i < digits.length; i++) {
        const currentParity = digits[i] % 2;
        const otherParity = 1 - currentParity;
        if (parityMap[otherParity] && parityMap[otherParity].length > 0) {
            const indexToSwap = parityMap[otherParity].pop();
            [digits[i], digits[indexToSwap]] = [digits[indexToSwap], digits[i]];
            break;
        }
    }
    return parseInt(digits.join(''), 10);
}