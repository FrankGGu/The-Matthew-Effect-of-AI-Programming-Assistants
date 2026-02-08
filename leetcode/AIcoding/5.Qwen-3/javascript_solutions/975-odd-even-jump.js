function oddEvenJumps(arr) {
    const n = arr.length;
    const sorted = [...arr].sort((a, b) => a - b);
    const map = new Map();
    for (let i = 0; i < n; i++) {
        map.set(sorted[i], i);
    }

    const odd = new Array(n).fill(false);
    const even = new Array(n).fill(false);
    odd[n - 1] = true;
    even[n - 1] = true;

    const nextOdd = new Array(n);
    const nextEven = new Array(n);

    for (let i = 0; i < n; i++) {
        const val = arr[i];
        const index = map.get(val);
        let j = index + 1;
        while (j < n && sorted[j] === val) j++;
        if (j < n) {
            nextOdd[i] = map.get(sorted[j]);
        } else {
            nextOdd[i] = -1;
        }
    }

    for (let i = 0; i < n; i++) {
        const val = arr[i];
        const index = map.get(val);
        let j = index - 1;
        while (j >= 0 && sorted[j] === val) j--;
        if (j >= 0) {
            nextEven[i] = map.get(sorted[j]);
        } else {
            nextEven[i] = -1;
        }
    }

    for (let i = n - 2; i >= 0; i--) {
        if (nextOdd[i] !== -1) {
            odd[i] = even[nextOdd[i]];
        }
        if (nextEven[i] !== -1) {
            even[i] = odd[nextEven[i]];
        }
    }

    let result = 0;
    for (let i = 0; i < n; i++) {
        if (odd[i]) result++;
    }
    return result;
}