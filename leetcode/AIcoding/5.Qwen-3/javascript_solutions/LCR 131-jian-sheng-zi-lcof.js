function minMovesToMakeStringGood(s) {
    let count = 0;
    let prev = s[0];
    for (let i = 1; i < s.length; i++) {
        if (s[i] === prev) {
            count++;
        } else {
            prev = s[i];
        }
    }
    return count;
}