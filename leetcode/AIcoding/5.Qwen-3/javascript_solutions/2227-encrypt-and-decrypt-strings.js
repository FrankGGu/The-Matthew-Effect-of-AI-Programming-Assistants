function encrypter(keys, values) {
    const map = {};
    for (let i = 0; i < keys.length; i++) {
        map[keys[i]] = values[i];
    }

    return function(s) {
        let result = '';
        for (let c of s) {
            if (map[c]) {
                result += map[c];
            } else {
                result += c;
            }
        }
        return result;
    };
}