function xorBeauty(a) {
    const n = a.length;
    let result = 0;
    for (let i = 0; i < n; i++) {
        let left = 0;
        for (let j = 0; j <= i; j++) {
            left ^= a[j];
        }
        let right = 0;
        for (let j = i; j < n; j++) {
            right ^= a[j];
        }
        result ^= (left & right);
    }
    return result;
}