function replaceDigits(s) {
    let result = '';
    for (let i = 0; i < s.length; i++) {
        if (i === 0 || isNaN(s[i])) {
            result += s[i];
        } else {
            const prevChar = s[i - 1];
            const offset = parseInt(s[i], 10);
            const newChar = String.fromCharCode(prevChar.charCodeAt(0) + offset);
            result += newChar;
        }
    }
    return result;
}