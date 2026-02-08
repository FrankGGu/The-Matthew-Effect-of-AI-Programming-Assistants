function maxTurbulenceSize(arr) {
    const n = arr.length;
    if (n <= 1) return n;

    let maxLen = 1;
    let start = 0;

    for (let i = 1; i < n; i++) {
        if (arr[i] === arr[i - 1]) {
            start = i;
        } else if (i == 1 || (arr[i] > arr[i - 1] && arr[i - 1] < arr[i - 2]) || (arr[i] < arr[i - 1] && arr[i - 1] > arr[i - 2])) {
            maxLen = Math.max(maxLen, i - start + 1);
        } else {
            start = i - 1;
        }
    }

    return maxLen;
}