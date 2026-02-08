function countEven(n) {
    function digitSum(x) {
        let sum = 0;
        while (x > 0) {
            sum += x % 10;
            x = Math.floor(x / 10);
        }
        return sum;
    }

    let count = 0;
    for (let i = 1; i <= n; i++) {
        if (digitSum(i) % 2 === 0) {
            count++;
        }
    }
    return count;
}