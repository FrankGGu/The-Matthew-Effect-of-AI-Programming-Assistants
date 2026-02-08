function magicalString(n) {
    if (n === 0) return 0;
    if (n <= 3) return 1;

    let res = 1;
    let i = 2;
    let j = 2;
    let arr = [1, 1, 2];

    while (j < n) {
        let next = arr[i] === 1 ? 2 : 1;
        for (let k = 0; k < arr[i]; k++) {
            arr.push(next);
            j++;
            if (j >= n) break;
        }
        i++;
    }

    for (let k = 0; k < n; k++) {
        if (arr[k] === 1) res++;
    }

    return res;
}