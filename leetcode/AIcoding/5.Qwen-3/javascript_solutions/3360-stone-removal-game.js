function canWin(s) {
    for (let i = 0; i < s.length - 1; i++) {
        if (s[i] === s[i + 1]) {
            const newS = s.substring(0, i) + s.substring(i + 2);
            if (!canWin(newS)) {
                return true;
            }
        }
    }
    return false;
}