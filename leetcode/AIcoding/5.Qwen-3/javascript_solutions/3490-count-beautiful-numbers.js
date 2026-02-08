function countBeautifulNumbers(n) {
    function isBeautiful(num) {
        let digits = new Set();
        while (num > 0) {
            let digit = num % 10;
            if (digits.has(digit)) return false;
            digits.add(digit);
            num = Math.floor(num / 10);
        }
        return true;
    }

    let count = 0;
    for (let i = 1; i <= n; i++) {
        if (isBeautiful(i)) count++;
    }
    return count;
}