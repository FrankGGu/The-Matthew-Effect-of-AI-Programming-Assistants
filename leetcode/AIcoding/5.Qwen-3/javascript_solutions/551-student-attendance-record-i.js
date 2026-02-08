function checkRecord(s) {
    let absentCount = 0;
    for (let i = 0; i < s.length; i++) {
        if (s[i] === 'A') {
            absentCount++;
            if (absentCount > 1) {
                return false;
            }
        } else if (s[i] === 'L' && i + 2 < s.length && s[i + 1] === 'L' && s[i + 2] === 'L') {
            return false;
        }
    }
    return true;
}