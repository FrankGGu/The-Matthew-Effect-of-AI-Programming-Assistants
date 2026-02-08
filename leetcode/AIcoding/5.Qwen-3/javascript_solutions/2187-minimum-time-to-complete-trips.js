function minimumTimeToCompleteTrips(time, totalTrips) {
    let left = 0;
    let right = Math.max(...time) * totalTrips;

    while (left < right) {
        const mid = Math.floor((left + right) / 2);
        let total = 0;
        for (const t of time) {
            total += Math.floor(mid / t);
            if (total >= totalTrips) break;
        }
        if (total >= totalTrips) {
            right = mid;
        } else {
            left = mid + 1;
        }
    }

    return left;
}