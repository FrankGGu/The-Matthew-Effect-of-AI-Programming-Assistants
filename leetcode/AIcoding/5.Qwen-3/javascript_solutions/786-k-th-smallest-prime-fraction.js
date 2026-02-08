function kthSmallestPrimeFraction(A, K) {
    const n = A.length;
    let left = 0, right = 1;

    while (left < right) {
        const mid = left + (right - left) / 2;
        let count = 0;
        let maxFraction = 0;
        let numerator = 0;
        let denominator = 1;

        for (let i = 0, j = 1; i < n; i++) {
            while (j < n && A[i] / A[j] > mid) {
                j++;
            }
            if (j < n) {
                count += n - j;
                if (A[i] / A[j] > maxFraction) {
                    maxFraction = A[i] / A[j];
                    numerator = A[i];
                    denominator = A[j];
                }
            }
        }

        if (count < K) {
            left = mid;
        } else {
            right = mid;
        }
    }

    return [numerator, denominator];
}