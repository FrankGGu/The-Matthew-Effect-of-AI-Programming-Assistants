function maximumTowers(heights) {
    const n = heights.length;
    let total = 0;
    let prev = 0;

    for (let i = 0; i < n; i++) {
        if (heights[i] > prev) {
            total += heights[i] - prev;
            prev = heights[i];
        }
    }

    return total;
}