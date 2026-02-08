var reorderedPowerOf2 = function(n) {
    const countDigits = (num) => {
        const count = new Array(10).fill(0);
        while (num > 0) {
            count[num % 10]++;
            num = Math.floor(num / 10);
        }
        return count;
    };

    const target = countDigits(n);
    for (let i = 0; i < 31; i++) {
        const powerOfTwo = Math.pow(2, i);
        const count = countDigits(powerOfTwo);
        if (target.every((val, index) => val === count[index])) {
            return true;
        }
    }
    return false;
};