function maxAreaOfLongestDiagonalRectangle(rectangles) {
    let maxDiagonal = 0;
    let maxArea = 0;

    for (const [x, y] of rectangles) {
        const diagonal = x * x + y * y;
        if (diagonal > maxDiagonal) {
            maxDiagonal = diagonal;
            maxArea = x * y;
        } else if (diagonal === maxDiagonal) {
            maxArea = Math.max(maxArea, x * y);
        }
    }

    return maxArea;
}