function minAnagramLength(s) {
    const count = new Array(26).fill(0);
    for (let c of s) {
        count[c.charCodeAt(0) - 'a'.charCodeAt(0)]++;
    }

    for (let i = 1; i <= s.length; i++) {
        if (s.length % i !== 0) continue;
        let valid = true;
        const temp = new Array(26).fill(0);
        for (let j = 0; j < i; j++) {
            temp[s[j].charCodeAt(0) - 'a'.charCodeAt(0)]++;
        }
        for (let j = 0; j < 26; j++) {
            if (temp[j] !== 0 && count[j] % temp[j] !== 0) {
                valid = false;
                break;
            }
        }
        if (valid) return i;
    }
    return s.length;
}