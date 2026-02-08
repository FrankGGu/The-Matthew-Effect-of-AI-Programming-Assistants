function selfDividingNumbers(left, right) {
    function isSelfDividing(n) {
        let num = n;
        while (num > 0) {
            let digit = num % 10;
            if (digit === 0 || n % digit !== 0) {
                return false;
            }
            num = Math.floor(num / 10);
        }
        return true;
    }

    const result = [];
    for (let i = left; i <= right; i++) {
        if (isSelfDividing(i)) {
            result.push(i);
        }
    }
    return result;
}