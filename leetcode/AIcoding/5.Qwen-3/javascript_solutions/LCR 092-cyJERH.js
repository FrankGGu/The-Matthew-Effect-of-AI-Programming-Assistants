var minFlipsMonotonic = function(s) {
    let flipCount = 0;
    let hasIncreased = false;
    for (let i = 0; i < s.length; i++) {
        if (s[i] === '1') {
            hasIncreased = true;
        } else if (hasIncreased) {
            flipCount++;
        }
    }
    return flipCount;
};