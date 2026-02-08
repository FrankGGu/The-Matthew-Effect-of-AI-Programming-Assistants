function isNumber(s) {
    s = s.trim();
    const eIndex = s.indexOf('e');
    if (eIndex === -1) {
        return isDecimal(s);
    } else {
        return isDecimal(s.substring(0, eIndex)) && isInteger(s.substring(eIndex + 1));
    }
}

function isDecimal(s) {
    if (s.length === 0) return false;
    if (s[0] === '+' || s[0] === '-') {
        s = s.substring(1);
    }
    if (s.length === 0) return false;
    let hasDot = false;
    for (let i = 0; i < s.length; i++) {
        if (s[i] === '.') {
            if (hasDot) return false;
            hasDot = true;
        } else if (s[i] < '0' || s[i] > '9') {
            return false;
        }
    }
    return true;
}

function isInteger(s) {
    if (s.length === 0) return false;
    if (s[0] === '+' || s[0] === '-') {
        s = s.substring(1);
    }
    if (s.length === 0) return false;
    for (let i = 0; i < s.length; i++) {
        if (s[i] < '0' || s[i] > '9') {
            return false;
        }
    }
    return true;
}