function atMostNInteger(n, k) {
    const digits = n.toString().split('');
    const len = digits.length;
    const kSet = k.split('');
    let result = 0;

    for (let i = 1; i < len; i++) {
        result += Math.pow(kSet.length, i);
    }

    for (let i = 0; i < len; i++) {
        const d = digits[i];
        const count = kSet.indexOf(d);
        if (count > -1) {
            result += Math.pow(kSet.length, len - i - 1);
        } else {
            break;
        }
    }

    return result;
}