function pancakeSorting(arr) {
    let res = [];
    let n = arr.length;
    for (let i = n; i > 1; i--) {
        let maxIndex = 0;
        for (let j = 1; j < i; j++) {
            if (arr[j] > arr[maxIndex]) {
                maxIndex = j;
            }
        }
        if (maxIndex === i - 1) continue;
        if (maxIndex !== 0) {
            reverse(arr, 0, maxIndex);
            res.push(maxIndex + 1);
        }
        reverse(arr, 0, i - 1);
        res.push(i);
    }
    return res;
}

function reverse(arr, start, end) {
    while (start < end) {
        let temp = arr[start];
        arr[start] = arr[end];
        arr[end] = temp;
        start++;
        end--;
    }
}