function eliminateMaximum(dist, speed) {
    const n = dist.length;
    const time = new Array(n);

    for (let i = 0; i < n; i++) {
        time[i] = dist[i] / speed[i];
    }

    time.sort((a, b) => a - b);

    for (let i = 0; i < n; i++) {
        if (time[i] <= i) {
            return i;
        }
    }

    return n;
}