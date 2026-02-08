var isNumberAfterDoubleReversal = function(num) {
    return num === parseInt(String(num).split('').reverse().join(''));
};