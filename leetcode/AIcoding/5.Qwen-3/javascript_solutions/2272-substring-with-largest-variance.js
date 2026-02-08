function largestVariance(s) {
    let maxVariance = 0;
    const uniqueChars = [...new Set(s)];

    for (let i = 0; i < uniqueChars.length; i++) {
        for (let j = 0; j < uniqueChars.length; j++) {
            if (i === j) continue;
            const a = uniqueChars[i];
            const b = uniqueChars[j];
            let hasB = false;
            let countA = 0;
            let countB = 0;
            let reset = false;

            for (const c of s) {
                if (c === a) countA++;
                else if (c === b) {
                    countB++;
                    hasB = true;
                }

                if (countB > 0 && countA < countB) {
                    countA = 0;
                    countB = 0;
                    hasB = false;
                    reset = true;
                }
            }

            if (hasB) {
                maxVariance = Math.max(maxVariance, countA - countB);
            }
        }
    }

    return maxVariance;
}