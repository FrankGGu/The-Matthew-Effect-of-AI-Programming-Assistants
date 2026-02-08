function digitCount(num) {
    const count = new Array(10).fill(0);
    for (const c of num) {
        count[parseInt(c)]++;
    }
    for (let i = 0; i < num.length; i++) {
        if (count[i] !== parseInt(num[i])) {
            return false;
        }
    }
    return true;
}