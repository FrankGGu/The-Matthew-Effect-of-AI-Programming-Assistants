function sumGame(p1, p2) {
    const count = (s) => {
        let sum = 0;
        let count = 0;
        for (let c of s) {
            if (c === ' ') continue;
            if (c === '_') count++;
            else sum += parseInt(c);
        }
        return [sum, count];
    };

    const [sum1, count1] = count(p1);
    const [sum2, count2] = count(p2);

    const totalSum = sum1 + sum2;
    const totalCount = count1 + count2;

    const target = Math.floor(totalSum / 2);
    const remaining = totalCount % 2 === 0 ? 0 : 1;

    return (totalSum % 2 === 0 && totalCount % 2 === 0) || (totalSum % 2 !== 0 && totalCount % 2 !== 0) ? false : true;
}