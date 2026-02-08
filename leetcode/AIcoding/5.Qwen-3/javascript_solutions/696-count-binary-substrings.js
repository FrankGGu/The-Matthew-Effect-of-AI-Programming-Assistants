function countBinarySubstrings(s) {
    let prev = 0, curr = 1, count = 0;
    for (let i = 1; i < s.length; i++) {
        if (s[i] === s[i - 1]) {
            curr++;
        } else {
            count += Math.min(prev, curr);
            prev = curr;
            curr = 1;
        }
    }
    count += Math.min(prev, curr);
    return count;
}