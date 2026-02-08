function findMinDifference(timePoints) {
    function toMinutes(time) {
        const [h, m] = time.split(':').map(Number);
        return h * 60 + m;
    }

    timePoints.sort((a, b) => toMinutes(a) - toMinutes(b));
    let minDiff = Infinity;

    for (let i = 0; i < timePoints.length; i++) {
        const curr = toMinutes(timePoints[i]);
        const next = toMinutes(timePoints[(i + 1) % timePoints.length]);
        const diff = (next - curr + 1440) % 1440;
        minDiff = Math.min(minDiff, diff);
    }

    return minDiff;
}