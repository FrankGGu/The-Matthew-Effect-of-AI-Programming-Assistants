function xorSum(a, b) {
    let result = 0;
    for (let i = 0; i < 32; i++) {
        let bitA = (a >> i) & 1;
        let bitB = (b >> i) & 1;
        if (bitA && bitB) {
            result |= (1 << i);
        }
    }
    return result;
}