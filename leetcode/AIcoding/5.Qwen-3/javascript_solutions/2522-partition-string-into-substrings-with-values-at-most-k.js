function partitionString(s, k) {
    let count = 0;
    let i = 0;
    while (i < s.length) {
        let num = 0;
        while (i < s.length && num * 10 + parseInt(s[i]) <= k) {
            num = num * 10 + parseInt(s[i]);
            i++;
        }
        if (num === 0) return -1;
        count++;
    }
    return count;
}