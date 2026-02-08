function maximumBags(capacity, rocks, additionalRocks) {
    const n = capacity.length;
    const diffs = new Array(n).fill(0);

    for (let i = 0; i < n; i++) {
        diffs[i] = capacity[i] - rocks[i];
    }

    diffs.sort((a, b) => a - b);

    let count = 0;

    for (let i = 0; i < n; i++) {
        if (diffs[i] <= 0) {
            count++;
        } else if (additionalRocks >= diffs[i]) {
            additionalRocks -= diffs[i];
            count++;
        } else {
            break;
        }
    }

    return count;
}