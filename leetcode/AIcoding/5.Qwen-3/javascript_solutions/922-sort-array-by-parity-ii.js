function sortArrayByParityII(A) {
    let i = 0, j = 1;
    const len = A.length;
    while (i < len && j < len) {
        if (A[i] % 2 === 0) {
            i += 2;
        } else if (A[j] % 2 === 1) {
            j += 2;
        } else {
            [A[i], A[j]] = [A[j], A[i]];
        }
    }
    return A;
}