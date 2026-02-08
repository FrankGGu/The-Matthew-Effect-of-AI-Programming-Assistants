function goodDaysToRobBank(security, time) {
    const n = security.length;
    const left = new Array(n).fill(0);
    const right = new Array(n).fill(0);

    for (let i = 1; i < n; i++) {
        if (security[i] <= security[i - 1]) {
            left[i] = left[i - 1] + 1;
        }
    }

    for (let i = n - 2; i >= 0; i--) {
        if (security[i] <= security[i + 1]) {
            right[i] = right[i + 1] + 1;
        }
    }

    const result = [];
    for (let i = 0; i < n; i++) {
        if (left[i] >= time && right[i] >= time) {
            result.push(i);
        }
    }

    return result;
}