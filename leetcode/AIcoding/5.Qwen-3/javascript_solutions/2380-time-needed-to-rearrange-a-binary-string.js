function timeRequiredToRearrange(s) {
    let n = s.length;
    let res = 0;
    let count = 0;
    for (let i = 0; i < n; i++) {
        if (s[i] === '1') {
            count++;
        } else {
            res += count;
        }
    }
    return res;
}