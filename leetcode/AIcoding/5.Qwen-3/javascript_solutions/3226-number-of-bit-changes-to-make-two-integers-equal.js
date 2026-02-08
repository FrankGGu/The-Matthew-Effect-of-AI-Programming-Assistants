function minChanges(a, b) {
    let xor = a ^ b;
    let count = 0;
    while (xor) {
        count += xor & 1;
        xor >>= 1;
    }
    return count;
}