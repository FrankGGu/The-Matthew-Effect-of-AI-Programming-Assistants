function shortestImpossibleSequence(rolls) {
    const set = new Set();
    let count = 0;
    for (const num of rolls) {
        if (!set.has(num)) {
            set.add(num);
            count++;
            if (count === 1) {
                return 1;
            }
        }
    }
    return count + 1;
}