function countGoodPartitions(s) {
    const last = {};
    for (let i = 0; i < s.length; i++) {
        last[s[i]] = i;
    }

    let res = 0;
    let prev = -1;

    for (let i = 0; i < s.length; i++) {
        if (i === prev) {
            res++;
        }
        prev = Math.max(prev, last[s[i]]);
    }

    return res;
}