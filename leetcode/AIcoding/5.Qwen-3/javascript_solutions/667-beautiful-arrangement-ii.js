function constructArray(n, k) {
    let result = new Array(n).fill(0);
    let i = 0;
    for (let j = 1; j <= n - k; j++) {
        result[i++] = j;
    }
    for (let j = n; j > n - k; j--) {
        result[i++] = j;
    }
    return result;
}