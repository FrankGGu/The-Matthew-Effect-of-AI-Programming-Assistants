function grayCode(n) {
    const result = [];
    for (let i = 0; i < Math.pow(2, n); i++) {
        result.push(i ^ (i >> 1));
    }
    return result;
}