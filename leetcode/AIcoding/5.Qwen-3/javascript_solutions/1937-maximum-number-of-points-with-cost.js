function maxPoints(points) {
    let m = points.length;
    let n = points[0].length;
    let prev = [...points[0]];

    for (let i = 1; i < m; i++) {
        let curr = new Array(n).fill(0);
        let left = new Array(n).fill(0);
        let right = new Array(n).fill(0);

        left[0] = prev[0];
        for (let j = 1; j < n; j++) {
            left[j] = Math.max(left[j - 1] - 1, prev[j]);
        }

        right[n - 1] = prev[n - 1];
        for (let j = n - 2; j >= 0; j--) {
            right[j] = Math.max(right[j + 1] - 1, prev[j]);
        }

        for (let j = 0; j < n; j++) {
            curr[j] = points[i][j] + Math.max(left[j], right[j]);
        }

        prev = curr;
    }

    return Math.max(...prev);
}