function maximumScore(intervals) {
    intervals.sort((a, b) => a[1] - b[1]);
    let score = 0;
    let lastEnd = -1;
    for (let [start, end] of intervals) {
        if (start > lastEnd) {
            score += end - start + 1;
            lastEnd = end;
        }
    }
    return score;
}