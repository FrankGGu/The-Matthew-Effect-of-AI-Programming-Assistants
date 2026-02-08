function maxTotalFruits(startPos, fruits, k) {
    const n = fruits.length;
    let maxFruits = 0;

    for (let i = 0; i < n; i++) {
        if (fruits[i][1] === 0) continue;
        const pos = fruits[i][0];
        const count = fruits[i][1];

        for (let j = i; j < n; j++) {
            if (fruits[j][1] === 0) continue;
            const endPos = fruits[j][0];
            const totalSteps = Math.abs(pos - startPos) + Math.abs(endPos - pos);
            if (totalSteps <= k) {
                let sum = 0;
                for (let m = i; m <= j; m++) {
                    sum += fruits[m][1];
                }
                maxFruits = Math.max(maxFruits, sum);
            } else {
                break;
            }
        }
    }

    return maxFruits;
}