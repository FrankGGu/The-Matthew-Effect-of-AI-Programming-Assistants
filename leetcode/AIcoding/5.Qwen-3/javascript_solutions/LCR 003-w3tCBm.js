function countBits(num) {
    const result = new Array(num + 1).fill(0);
    for (let i = 1; i <= num; i++) {
        result[i] = result[i >> 1] + (i & 1);
    }
    return result;
}