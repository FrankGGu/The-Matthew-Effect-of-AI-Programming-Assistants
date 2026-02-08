function largestSquareArea(r1, r2) {
    const x1 = Math.max(r1[0], r2[0]);
    const y1 = Math.max(r1[1], r2[1]);
    const x2 = Math.min(r1[2], r2[2]);
    const y2 = Math.min(r1[3], r2[3]);

    if (x1 >= x2 || y1 >= y2) return 0;

    const side = Math.min(x2 - x1, y2 - y1);
    return side * side;
}