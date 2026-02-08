function minKBitFlips(bits, k) {
    const n = bits.length;
    const flip = new Array(n).fill(0);
    let flipCount = 0;
    let result = 0;

    for (let i = 0; i < n; i++) {
        if (flip[i] === 1) {
            flipCount++;
        }

        if (bits[i] === 0 && flipCount % 2 === 0) {
            result++;
            flipCount++;
            if (i + k <= n) {
                flip[i + k] -= 1;
            }
        } else if (bits[i] === 1 && flipCount % 2 === 1) {
            result++;
            flipCount++;
            if (i + k <= n) {
                flip[i + k] -= 1;
            }
        }
    }

    return result;
}