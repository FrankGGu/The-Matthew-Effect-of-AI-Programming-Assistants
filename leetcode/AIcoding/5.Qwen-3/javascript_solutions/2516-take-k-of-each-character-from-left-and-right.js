function takeKOfEachCharacterFromLeftAndRight(s, k) {
    const count = new Array(26).fill(0);
    for (const c of s) {
        count[c.charCodeAt(0) - 'a'.charCodeAt(0)]++;
    }

    let left = 0;
    let right = s.length - 1;
    let res = 0;

    while (left <= right) {
        if (count[s[left].charCodeAt(0) - 'a'.charCodeAt(0)] > k) {
            count[s[left].charCodeAt(0) - 'a'.charCodeAt(0)]--;
            left++;
            res++;
        } else if (count[s[right].charCodeAt(0) - 'a'.charCodeAt(0)] > k) {
            count[s[right].charCodeAt(0) - 'a'.charCodeAt(0)]--;
            right--;
            res++;
        } else {
            break;
        }
    }

    return res;
}