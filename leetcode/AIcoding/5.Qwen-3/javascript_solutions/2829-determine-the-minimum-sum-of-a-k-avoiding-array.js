function minimumSum(n, k) {
    let sum = 0;
    let used = new Set();
    let num = 1;

    while (used.size < n) {
        if (!used.has(num)) {
            sum += num;
            for (let i = num + k; i <= num + k + 100; i++) {
                used.add(i);
            }
        }
        num++;
    }

    return sum;
}