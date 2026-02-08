function minRectanglesToCoverPoints(points) {
    const xSet = new Set();
    const ySet = new Set();

    for (const [x, y] of points) {
        xSet.add(x);
        ySet.add(y);
    }

    return Math.min(xSet.size, ySet.size);
}