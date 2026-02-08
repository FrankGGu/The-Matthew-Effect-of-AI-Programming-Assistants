function kDivisibleElementsSubarrays(arr, k) {
    const n = arr.length;
    let count = 0;
    for (let i = 0; i < n; i++) {
        let sum = 0;
        for (let j = i; j < n; j++) {
            sum += arr[j];
            if (sum % k === 0) {
                count++;
            }
        }
    }
    return count;
}