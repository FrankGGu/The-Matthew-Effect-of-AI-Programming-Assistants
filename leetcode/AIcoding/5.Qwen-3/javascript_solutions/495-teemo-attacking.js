function findPoisonedDuration(timeSeries, duration) {
    if (timeSeries.length === 0 || duration === 0) return 0;
    let total = 0;
    for (let i = 1; i < timeSeries.length; i++) {
        total += Math.min(timeSeries[i] - timeSeries[i - 1], duration);
    }
    return total + duration;
}