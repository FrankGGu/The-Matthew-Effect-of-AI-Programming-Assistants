function repeatLimitedString(a, b) {
    const count = new Array(26).fill(0);
    for (let c of a) count[c.charCodeAt(0) - 'a'.charCodeAt(0)]++;
    for (let c of b) count[c.charCodeAt(0) - 'a'.charCodeAt(0)]++;

    let res = [];
    let i = 25, j = 24;

    while (i >= 0 && count[i] > 0) {
        let use = Math.min(count[i], 2);
        for (let k = 0; k < use; k++) {
            res.push(String.fromCharCode(i + 'a'.charCodeAt(0)));
            count[i]--;
        }

        if (count[i] === 0) {
            i--;
            continue;
        }

        if (j < 0 || count[j] === 0) {
            j = i - 1;
            while (j >= 0 && count[j] === 0) j--;
        }

        if (j >= 0) {
            res.push(String.fromCharCode(j + 'a'.charCodeAt(0)));
            count[j]--;
        } else {
            break;
        }
    }

    return res.join('');
}