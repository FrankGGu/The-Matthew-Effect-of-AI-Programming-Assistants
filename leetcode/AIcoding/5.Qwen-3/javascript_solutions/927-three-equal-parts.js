function threeEqualParts(arr) {
    const n = arr.length;
    const ones = [];
    for (let i = 0; i < n; i++) {
        if (arr[i] === 1) {
            ones.push(i);
        }
    }
    if (ones.length % 3 !== 0) return [-1, -1];
    if (ones.length === 0) return [0, 2];
    const k = ones.length / 3;
    const first = ones[0];
    const second = ones[k];
    const third = ones[2 * k];
    const len = n - third;
    if (first + len > second || second + len > third) return [-1, -1];
    let i = 0;
    let j = first;
    while (j < first + len) {
        if (arr[j] !== arr[i]) return [-1, -1];
        j++;
        i++;
    }
    j = second;
    i = 0;
    while (j < second + len) {
        if (arr[j] !== arr[i]) return [-1, -1];
        j++;
        i++;
    }
    j = third;
    i = 0;
    while (j < n) {
        if (arr[j] !== arr[i]) return [-1, -1];
        j++;
        i++;
    }
    return [first + len, second + len];
}