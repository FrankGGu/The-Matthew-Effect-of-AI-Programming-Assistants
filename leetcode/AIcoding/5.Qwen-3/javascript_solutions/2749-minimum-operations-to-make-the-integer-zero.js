var minimumOperations = function(num) {
    let count = 0;
    while (num > 0) {
        if (num % 10 === 0) {
            num /= 10;
        } else {
            num -= 1;
        }
        count++;
    }
    return count;
};