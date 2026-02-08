var rotatedDigits = function(N) {
    const invalid = new Set(['3', '4', '7']);
    const valid = new Set(['2', '5', '6', '9']);
    let count = 0;
    for (let i = 1; i <= N; i++) {
        const s = i.toString();
        let hasValid = false;
        for (let c of s) {
            if (invalid.has(c)) {
                hasValid = false;
                break;
            }
            if (valid.has(c)) {
                hasValid = true;
            }
        }
        if (hasValid) {
            count++;
        }
    }
    return count;
};