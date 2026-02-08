function smallestGoodBase(n) {
    const N = parseInt(n);
    for (let k = 1; k <= Math.log2(N) + 1; k++) {
        let low = 2;
        let high = N - 1;
        while (low <= high) {
            let mid = Math.floor((low + high) / 2);
            let sum = 0;
            let current = 1;
            for (let i = 0; i < k; i++) {
                sum += current;
                current *= mid;
                if (sum > N) break;
            }
            if (sum === N) return mid.toString();
            else if (sum < N) low = mid + 1;
            else high = mid - 1;
        }
    }
    return (N - 1).toString();
}