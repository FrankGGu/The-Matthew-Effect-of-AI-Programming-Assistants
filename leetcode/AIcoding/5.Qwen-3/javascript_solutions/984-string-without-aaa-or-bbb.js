function strWithout3a3b(a, b) {
    let result = [];
    while (a > 0 || b > 0) {
        let first = false;
        if (a > b) {
            result.push('a');
            a--;
            first = true;
        }
        if (b > 0 && (a <= b || !first)) {
            result.push('b');
            b--;
        }
    }
    return result.join('');
}