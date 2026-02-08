function canMakeEqual(x, y) {
    const count = (num) => {
        let res = 0;
        while (num > 0) {
            res += num % 10;
            num = Math.floor(num / 10);
        }
        return res;
    };
    return count(x) === count(y);
}