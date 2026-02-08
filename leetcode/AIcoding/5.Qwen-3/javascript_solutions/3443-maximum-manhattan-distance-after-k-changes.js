function maxDistance(points) {
    let max = 0;
    for (let i = 0; i < points.length; i++) {
        for (let j = i + 1; j < points.length; j++) {
            const distance = Math.abs(points[i] - points[j]);
            if (distance > max) {
                max = distance;
            }
        }
    }
    return max;
}