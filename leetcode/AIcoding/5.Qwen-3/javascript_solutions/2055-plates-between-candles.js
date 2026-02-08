function platesBetweenCandles(plates, queries) {
    const n = plates.length;
    const left = new Array(n).fill(0);
    const right = new Array(n).fill(0);
    const prefix = new Array(n).fill(0);

    let prev = -1;
    for (let i = 0; i < n; i++) {
        if (plates[i] === '*') {
            left[i] = prev;
        } else {
            left[i] = i;
            prev = i;
        }
    }

    prev = -1;
    for (let i = n - 1; i >= 0; i--) {
        if (plates[i] === '*') {
            right[i] = prev;
        } else {
            right[i] = i;
            prev = i;
        }
    }

    let count = 0;
    for (let i = 0; i < n; i++) {
        if (plates[i] === '*') {
            count++;
        }
        prefix[i] = count;
    }

    const result = [];
    for (const [l, r] of queries) {
        let leftIdx = right[l];
        let rightIdx = left[r];
        if (leftIdx === -1 || rightIdx === -1 || leftIdx >= rightIdx) {
            result.push(0);
        } else {
            result.push(prefix[rightIdx] - prefix[leftIdx]);
        }
    }

    return result;
}