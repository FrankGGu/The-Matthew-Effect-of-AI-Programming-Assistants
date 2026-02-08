function diStringMatch(s) {
    let low = 0, high = s.length;
    const result = [];

    for (let i = 0; i < s.length; i++) {
        if (s[i] === 'I') {
            result.push(low);
            low++;
        } else {
            result.push(high);
            high--;
        }
    }

    result.push(low);
    return result;
}