function maxMoneyEarned(money) {
    if (money.length === 0) return 0;
    if (money.length === 1) return money[0];
    if (money.length === 2) return Math.max(money[0], money[1]);

    let prevPrev = money[0];
    let prev = Math.max(money[0], money[1]);
    for (let i = 2; i < money.length; i++) {
        let current = Math.max(prev, prevPrev + money[i]);
        prevPrev = prev;
        prev = current;
    }

    return prev;
}