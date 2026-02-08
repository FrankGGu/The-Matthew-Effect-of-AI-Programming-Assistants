function findGoodIndices(s, k) {
    const n = s.length;
    const good = new Array(n).fill(false);
    const left = new Array(n).fill(0);
    const right = new Array(n).fill(0);

    for (let i = 1; i < n; i++) {
        if (s[i] === s[i - 1]) {
            left[i] = left[i - 1] + 1;
        }
    }

    for (let i = n - 2; i >= 0; i--) {
        if (s[i] === s[i + 1]) {
            right[i] = right[i + 1] + 1;
        }
    }

    for (let i = 0; i < n; i++) {
        if (i - k >= 0 && i + k < n) {
            if (left[i - 1] >= k - 1 && right[i + 1] >= k - 1) {
                good[i] = true;
            }
        }
    }

    const result = [];
    for (let i = 0; i < n; i++) {
        if (good[i]) {
            result.push(i);
        }
    }
    return result;
}