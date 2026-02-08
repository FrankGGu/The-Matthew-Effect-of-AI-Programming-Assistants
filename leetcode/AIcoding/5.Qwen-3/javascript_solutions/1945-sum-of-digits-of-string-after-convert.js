function getLucky(s, k) {
    let numStr = '';
    for (let c of s) {
        numStr += c.charCodeAt(0) - 'a'.charCodeAt(0) + 1;
    }
    while (k > 0) {
        let sum = 0;
        for (let c of numStr) {
            sum += parseInt(c);
        }
        numStr = sum.toString();
        k--;
    }
    return parseInt(numStr);
}