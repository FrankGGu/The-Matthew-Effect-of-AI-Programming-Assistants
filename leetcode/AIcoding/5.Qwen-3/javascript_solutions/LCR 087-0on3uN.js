function restoreIpAddresses(s) {
    const result = [];
    const n = s.length;
    for (let i = 1; i <= 3 && i < n; i++) {
        for (let j = i + 1; j <= i + 3 && j < n; j++) {
            for (let k = j + 1; k <= j + 3 && k < n; k++) {
                const part1 = s.substring(0, i);
                const part2 = s.substring(i, j);
                const part3 = s.substring(j, k);
                const part4 = s.substring(k);
                if (isValid(part1) && isValid(part2) && isValid(part3) && isValid(part4)) {
                    result.push(part1 + '.' + part2 + '.' + part3 + '.' + part4);
                }
            }
        }
    }
    return result;
}

function isValid(s) {
    if (s.length === 0 || s.length > 3) return false;
    if (s.length > 1 && s[0] === '0') return false;
    const num = parseInt(s, 10);
    return num >= 0 && num <= 255;
}