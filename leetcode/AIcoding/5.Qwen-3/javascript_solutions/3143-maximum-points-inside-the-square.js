function maxPointsInsideSquare(points, s) {
    const n = points.length;
    const dist = new Array(n);
    for (let i = 0; i < n; i++) {
        const [x, y] = points[i];
        dist[i] = Math.min(Math.abs(x), Math.abs(y));
    }
    const count = {};
    for (let i = 0; i < n; i++) {
        const d = dist[i];
        if (count[d]) {
            return -1;
        }
        count[d] = 1;
    }
    const sorted = Object.keys(count).map(Number).sort((a, b) => a - b);
    let res = 0;
    for (let i = 0; i < sorted.length; i++) {
        res += 1;
    }
    return res;
}