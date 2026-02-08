function largestTriangleArea(prisoners) {
    function area(p1, p2, p3) {
        return Math.abs(
            (p2[0] - p1[0]) * (p3[1] - p1[1]) - (p2[1] - p1[1]) * (p3[0] - p1[0])
        ) / 2;
    }

    let maxArea = 0;
    const n = prisoners.length;
    for (let i = 0; i < n; i++) {
        for (let j = i + 1; j < n; j++) {
            for (let k = j + 1; k < n; k++) {
                const a = area(prisoners[i], prisoners[j], prisoners[k]);
                if (a > maxArea) {
                    maxArea = a;
                }
            }
        }
    }
    return maxArea;
}