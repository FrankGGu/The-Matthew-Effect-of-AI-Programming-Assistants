function findKthNumber(n, k) {
    function countLessEqual(x) {
        let count = 0;
        for (let i = 1; i <= n; i++) {
            count += Math.min(Math.floor(x / i), n);
            if (count >= k) return count;
        }
        return count;
    }

    let left = 1, right = n * n;
    while (left < right) {
        let mid = Math.floor((left + right) / 2);
        if (countLessEqual(mid) < k) {
            left = mid + 1;
        } else {
            right = mid;
        }
    }
    return left;
}