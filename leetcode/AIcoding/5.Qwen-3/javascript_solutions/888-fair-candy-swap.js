function fairCandySwap(A, B) {
    const sumA = A.reduce((a, b) => a + b, 0);
    const sumB = B.reduce((a, b) => a + b, 0);
    const diff = (sumA - sumB) / 2;
    const setB = new Set(B);
    for (let a of A) {
        if (setB.has(a - diff)) {
            return [a, a - diff];
        }
    }
}