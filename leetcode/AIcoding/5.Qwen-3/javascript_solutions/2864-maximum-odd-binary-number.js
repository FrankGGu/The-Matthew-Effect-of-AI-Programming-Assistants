var maximumOddBinaryNumber = function(s) {
    let count = 0;
    for (let c of s) {
        if (c === '1') count++;
    }
    return '1'.repeat(count - 1) + '0'.repeat(s.length - count) + '1';
};