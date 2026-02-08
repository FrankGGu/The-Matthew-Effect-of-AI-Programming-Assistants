var hasAlternatingBits = function(n) {
    let prev = n & 1;
    n >>>= 1;
    while (n > 0) {
        let current = n & 1;
        if (current === prev) return false;
        prev = current;
        n >>>= 1;
    }
    return true;
};