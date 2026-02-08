function decodeMessage(key, message) {
    const map = {};
    let index = 0;
    for (const char of key) {
        if (char !== ' ' && !(char in map)) {
            map[char] = String.fromCharCode(97 + index++);
        }
    }
    let result = '';
    for (const char of message) {
        if (char === ' ') {
            result += ' ';
        } else {
            result += map[char];
        }
    }
    return result;
}