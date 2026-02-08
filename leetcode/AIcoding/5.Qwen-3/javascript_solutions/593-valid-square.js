var validSquare = function(p1, p2, p3, p4) {
    const dist = (a, b) => Math.hypot(a[0] - b[0], a[1] - b[1]);
    const d1 = dist(p1, p2);
    const d2 = dist(p1, p3);
    const d3 = dist(p1, p4);
    const d4 = dist(p2, p3);
    const d5 = dist(p2, p4);
    const d6 = dist(p3, p4);

    const distances = [d1, d2, d3, d4, d5, d6].sort((a, b) => a - b);

    return distances[0] > 0 && distances[0] === distances[1] && distances[1] === distances[2] && distances[2] === distances[3] && distances[4] === distances[5] && distances[3] === distances[4];
};