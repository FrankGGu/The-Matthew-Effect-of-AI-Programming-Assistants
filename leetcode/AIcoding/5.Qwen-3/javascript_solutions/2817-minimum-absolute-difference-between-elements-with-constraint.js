function minimumAbsoluteDifference(arr, a, b) {
    let minDiff = Infinity;
    const map = new Map();

    for (let i = 0; i < arr.length; i++) {
        const num = arr[i];
        if (map.has(a - num)) {
            minDiff = Math.min(minDiff, Math.abs(num - (a - num)));
        }
        if (map.has(b - num)) {
            minDiff = Math.min(minDiff, Math.abs(num - (b - num)));
        }
        map.set(num, true);
    }

    return minDiff;
}