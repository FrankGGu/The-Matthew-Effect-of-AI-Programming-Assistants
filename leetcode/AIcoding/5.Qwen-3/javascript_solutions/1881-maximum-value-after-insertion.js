var maximumValue = function(num) {
    for (let i = 0; i < num.length; i++) {
        if (num[i] < '9') {
            return num.substring(0, i) + (parseInt(num[i]) + 1).toString() + '9'.repeat(num.length - i - 1);
        }
    }
    return num + '9';
};