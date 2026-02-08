function partitionString(s) {
    const lastOccurrence = {};
    let result = 0;
    let start = 0;

    for (let i = 0; i < s.length; i++) {
        if (lastOccurrence[s[i]] >= start) {
            start = i;
            result++;
        }
        lastOccurrence[s[i]] = i;
    }

    return result + 1;
}