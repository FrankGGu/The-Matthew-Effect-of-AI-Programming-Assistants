function findKthCharacter(s, n, k) {
    let len = s.length;
    for (let i = 0; i < n; i++) {
        let newLen = 0;
        for (let j = 0; j < len; j++) {
            newLen += s[j] === 'a' ? 1 : 2;
        }
        len = newLen;
    }
    for (let i = n - 1; i >= 0; i--) {
        if (k === 1) {
            return s[0];
        }
        let count = 0;
        for (let j = 0; j < s.length; j++) {
            if (s[j] === 'a') {
                count++;
            } else {
                count += 2;
            }
        }
        if (k > count) {
            k -= count;
            continue;
        }
        let temp = '';
        for (let j = 0; j < s.length; j++) {
            if (s[j] === 'a') {
                temp += 'a';
            } else {
                temp += 'ab';
            }
        }
        s = temp;
    }
    return s[k - 1];
}