function sortEvenOdd(arr) {
    const even = [];
    const odd = [];
    for (let i = 0; i < arr.length; i++) {
        if (i % 2 === 0) {
            even.push(arr[i]);
        } else {
            odd.push(arr[i]);
        }
    }
    even.sort((a, b) => a - b);
    odd.sort((a, b) => b - a);
    let e = 0, o = 0;
    for (let i = 0; i < arr.length; i++) {
        if (i % 2 === 0) {
            arr[i] = even[e++];
        } else {
            arr[i] = odd[o++];
        }
    }
    return arr;
}