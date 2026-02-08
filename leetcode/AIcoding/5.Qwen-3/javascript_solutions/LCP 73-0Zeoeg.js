function findMinimumTime(n, logs) {
    logs.sort((a, b) => a[0] - b[0]);
    let time = 0;
    let prev = 0;
    for (let i = 0; i < n; i++) {
        const [start, end] = logs[i];
        if (prev >= end) continue;
        if (prev < start) {
            time += end - start + 1;
            prev = end;
        } else {
            time += end - prev;
            prev = end;
        }
    }
    return time;
}