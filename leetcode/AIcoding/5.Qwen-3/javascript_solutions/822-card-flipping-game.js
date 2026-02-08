function flipgame(fronts, backs) {
    const seen = new Set();
    const candidates = new Set();

    for (let i = 0; i < fronts.length; i++) {
        if (fronts[i] === backs[i]) {
            seen.add(fronts[i]);
        } else {
            candidates.add(fronts[i]);
            candidates.add(backs[i]);
        }
    }

    for (const num of candidates) {
        if (!seen.has(num)) {
            return num;
        }
    }

    return 0;
}