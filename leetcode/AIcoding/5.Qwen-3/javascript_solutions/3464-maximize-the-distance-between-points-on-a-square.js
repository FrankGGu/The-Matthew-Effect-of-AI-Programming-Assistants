function maxDistance(points) {
    let max1 = -Infinity, max2 = -Infinity, min1 = Infinity, min2 = Infinity;

    for (const [x, y] of points) {
        const d1 = x + y;
        const d2 = x - y;

        if (d1 > max1) max1 = d1;
        if (d1 < min1) min1 = d1;

        if (d2 > max2) max2 = d2;
        if (d2 < min2) min2 = d2;
    }

    return Math.max(max1 - min1, max2 - min2);
}