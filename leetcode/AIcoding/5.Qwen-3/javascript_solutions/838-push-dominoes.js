function pushDominoes(dominoes) {
    const n = dominoes.length;
    const left = new Array(n).fill(0);
    const right = new Array(n).fill(0);
    let count = 0;

    for (let i = 0; i < n; i++) {
        if (dominoes[i] === 'R') {
            count = 1;
        } else if (dominoes[i] === 'L') {
            count = 0;
        } else {
            right[i] = count;
        }
    }

    count = 0;
    for (let i = n - 1; i >= 0; i--) {
        if (dominoes[i] === 'L') {
            count = 1;
        } else if (dominoes[i] === 'R') {
            count = 0;
        } else {
            left[i] = count;
        }
    }

    const result = [];
    for (let i = 0; i < n; i++) {
        if (right[i] > left[i]) {
            result.push('R');
        } else if (left[i] > right[i]) {
            result.push('L');
        } else {
            result.push('.');
        }
    }

    return result.join('');
}