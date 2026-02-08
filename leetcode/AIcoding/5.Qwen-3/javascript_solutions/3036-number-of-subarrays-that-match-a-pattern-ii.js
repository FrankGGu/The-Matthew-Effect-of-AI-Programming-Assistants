function numberOfMatchingSubarrays(str, pattern) {
    const n = str.length;
    const m = pattern.length;
    if (m === 0 || n < m) return 0;

    const buildFailureFunction = (pattern) => {
        const fail = new Array(pattern.length).fill(0);
        let j = 0;
        for (let i = 1; i < pattern.length; i++) {
            while (j > 0 && pattern[i] !== pattern[j]) {
                j = fail[j - 1];
            }
            if (pattern[i] === pattern[j]) {
                j++;
                fail[i] = j;
            }
        }
        return fail;
    };

    const fail = buildFailureFunction(pattern);
    let count = 0;
    let j = 0;
    for (let i = 0; i < n; i++) {
        while (j > 0 && str[i] !== pattern[j]) {
            j = fail[j - 1];
        }
        if (str[i] === pattern[j]) {
            j++;
        }
        if (j === m) {
            count++;
            j = fail[j - 1];
        }
    }
    return count;
}