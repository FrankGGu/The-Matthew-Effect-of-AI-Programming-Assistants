function timeToCross(ranks) {
    const n = ranks.length;
    if (n === 0) return 0;
    if (n === 1) return ranks[0];
    if (n === 2) return Math.max(ranks[0], ranks[1]);
    if (n === 3) return ranks[0] + ranks[1] + ranks[2];

    ranks.sort((a, b) => a - b);
    let total = 0;

    while (ranks.length > 3) {
        const first = ranks[0];
        const second = ranks[1];
        const last = ranks[ranks.length - 1];
        const secondLast = ranks[ranks.length - 2];

        const option1 = first + second + last + secondLast;
        const option2 = first + last + first + second;

        if (option1 < option2) {
            total += option1;
        } else {
            total += option2;
        }

        ranks.pop();
        ranks.pop();
    }

    total += ranks[0] + ranks[1] + ranks[2];
    return total;
}