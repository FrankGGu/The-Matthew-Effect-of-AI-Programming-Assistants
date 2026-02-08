function canBeValid(s) {
    if (s.length % 2 !== 0) return false;
    let open = 0;
    let close = 0;
    for (let i = 0; i < s.length; i++) {
        if (s[i] === '(') {
            open++;
        } else {
            close++;
        }
        if (close > open) return false;
    }
    return open === close;
}