function maximumGood(statements) {
    const n = statements.length;
    let maxGood = 0;

    for (let mask = 0; mask < (1 << n); mask++) {
        let isConsistent = true;
        for (let i = 0; i < n; i++) {
            if ((mask & (1 << i)) === 0) continue;
            for (let j = 0; j < n; j++) {
                if ((mask & (1 << j)) && statements[i][j] === 0) {
                    isConsistent = false;
                    break;
                }
                if (!(mask & (1 << j)) && statements[i][j] === 1) {
                    isConsistent = false;
                    break;
                }
            }
            if (!isConsistent) break;
        }
        if (isConsistent) {
            let count = 0;
            for (let i = 0; i < n; i++) {
                if (mask & (1 << i)) count++;
            }
            maxGood = Math.max(maxGood, count);
        }
    }

    return maxGood;
}