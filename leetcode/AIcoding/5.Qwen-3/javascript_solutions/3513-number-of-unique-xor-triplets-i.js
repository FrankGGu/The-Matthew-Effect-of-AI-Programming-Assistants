function countTriplets(arr) {
    const n = arr.length;
    let count = 0;
    for (let i = 0; i < n; i++) {
        for (let j = i + 1; j < n; j++) {
            for (let k = j + 1; k < n; k++) {
                if ((arr[i] ^ arr[j]) === (arr[j] ^ arr[k])) {
                    count++;
                }
            }
        }
    }
    return count;
}