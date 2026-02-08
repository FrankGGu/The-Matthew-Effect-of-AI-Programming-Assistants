function largeGroupPositions(s) {
    const result = [];
    let start = 0;
    for (let i = 1; i < s.length; i++) {
        if (s[i] !== s[i - 1]) {
            if (i - start >= 3) {
                result.push([start, i - 1]);
            }
            start = i;
        }
    }
    if (s.length - start >= 3) {
        result.push([start, s.length - 1]);
    }
    return result;
}