function substringXorQueries(s) {
    const n = s.length;
    const result = [];
    for (let i = 0; i < n; i++) {
        if (s[i] === '0') {
            result.push([i, i]);
            continue;
        }
        let xor = 0;
        for (let j = i; j < n; j++) {
            xor ^= (s[j] === '1' ? 1 : 0);
            if (xor === 0) {
                result.push([i, j]);
                break;
            }
        }
    }
    return result;
}