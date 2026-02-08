function maxOperations(s) {
    let count = 0;
    let ones = 0;
    for (let i = 0; i < s.length; i++) {
        if (s[i] === '1') {
            ones++;
        } else {
            count += ones;
        }
    }
    return count;
}