function countPairs(points, k) {
    let count = 0;
    const n = points.length;
    for (let i = 0; i < n; i++) {
        for (let j = i + 1; j < n; j++) {
            const dx = points[i][0] - points[j][0];
            const dy = points[i][1] - points[j][1];
            if (dx * dx + dy * dy === k * k) {
                count++;
            }
        }
    }
    return count;
}