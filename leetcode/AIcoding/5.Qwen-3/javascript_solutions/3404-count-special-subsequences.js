function countSpecialSubsequences(s) {
    let a = 0, ab = 0, abc = 0;
    for (let c of s) {
        if (c === 'a') {
            a = (a + 1) % (10**9 + 7);
        } else if (c === 'b') {
            ab = (ab + a) % (10**9 + 7);
        } else if (c === 'c') {
            abc = (abc + ab) % (10**9 + 7);
        }
    }
    return abc;
}