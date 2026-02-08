function splitString(s) {
    const n = s.length;
    for (let i = 1; i < n; i++) {
        let left = s.substring(0, i);
        let right = s.substring(i);
        if (parseInt(left) - parseInt(right) === 0) {
            return true;
        }
    }
    return false;
}