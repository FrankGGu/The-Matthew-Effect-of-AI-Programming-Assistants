function countOperationsToMakeZero(n) {
    let operations = 0;
    while (n > 0) {
        if (n % 2 === 1) {
            n--;
        } else {
            n /= 2;
        }
        operations++;
    }
    return operations;
}