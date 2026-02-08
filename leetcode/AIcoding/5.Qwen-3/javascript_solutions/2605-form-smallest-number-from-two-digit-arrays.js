function minNumber(a, b) {
    let set = new Set([...a, ...b]);
    let min1 = Infinity;
    let min2 = Infinity;
    for (let num of set) {
        if (num < min1) {
            min2 = min1;
            min1 = num;
        } else if (num < min2) {
            min2 = num;
        }
    }
    return Math.min(min1 * 10 + min2, min2 * 10 + min1);
}