function findEvenNumbers(arr) {
    const result = new Set();
    const n = arr.length;
    for (let i = 0; i < n; i++) {
        for (let j = 0; j < n; j++) {
            if (j === i) continue;
            for (let k = 0; k < n; k++) {
                if (k === i || k === j) continue;
                const num = arr[i] * 100 + arr[j] * 10 + arr[k];
                if (num % 2 === 0) {
                    result.add(num);
                }
            }
        }
    }
    return Array.from(result).length;
}