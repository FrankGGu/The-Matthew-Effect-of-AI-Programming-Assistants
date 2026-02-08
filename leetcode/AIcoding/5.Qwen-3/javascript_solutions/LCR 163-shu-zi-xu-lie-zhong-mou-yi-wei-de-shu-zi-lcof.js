function findKthNumber(k) {
    let n = 1;
    while (true) {
        let count = 0;
        let first = n;
        let last = n + 1;
        while (first <= k) {
            count += Math.min(k + 1, last) - first;
            first *= 10;
            last *= 10;
        }
        if (count > k) {
            return n;
        } else {
            k -= count;
            n++;
        }
    }
}