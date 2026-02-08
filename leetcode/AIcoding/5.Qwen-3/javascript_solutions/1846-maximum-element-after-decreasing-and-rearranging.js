function maximumElementAfterDecreasingAndRearranging(arr) {
    arr.sort((a, b) => a - b);
    let n = arr.length;
    for (let i = n - 2; i >= 0; i--) {
        if (arr[i] > arr[i + 1] - 1) {
            arr[i] = arr[i + 1] - 1;
        }
    }
    return arr[0];
}