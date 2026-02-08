function canTransform(s, t) {
    let i = 0, j = 0;
    while (i < s.length && j < t.length) {
        if (s[i] === t[j]) {
            i++;
            j++;
        } else if (s[i] === 'L') {
            return false;
        } else if (t[j] === 'R') {
            return false;
        } else if (s[i] === 'R') {
            if (j >= t.length || t[j] !== 'R') {
                return false;
            }
            i++;
            j++;
        } else if (t[j] === 'L') {
            if (i >= s.length || s[i] !== 'L') {
                return false;
            }
            i++;
            j++;
        } else {
            return false;
        }
    }
    while (i < s.length) {
        if (s[i++] !== 'L') return false;
    }
    while (j < t.length) {
        if (t[j++] !== 'R') return false;
    }
    return true;
}