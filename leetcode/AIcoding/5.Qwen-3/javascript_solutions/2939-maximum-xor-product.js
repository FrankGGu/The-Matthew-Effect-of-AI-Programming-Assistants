function maximumXorProduct(r, k) {
    let a = 1n, b = 1n;
    for (let i = 0; i < k.length; i++) {
        if (k[i] === '0') {
            a = (a << 1n) | 1n;
        } else {
            b = (b << 1n) | 1n;
        }
    }
    return (a ^ b).toString();
}