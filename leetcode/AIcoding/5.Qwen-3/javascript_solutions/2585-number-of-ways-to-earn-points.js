function numberOfWays(points) {
    const map = new Map();
    for (let i = 0; i < points.length; i++) {
        for (let j = i + 1; j < points.length; j++) {
            const dx = points[j][0] - points[i][0];
            const dy = points[j][1] - points[i][1];
            const key = `${dx},${dy}`;
            map.set(key, (map.get(key) || 0) + 1);
        }
    }

    let result = 0;
    for (const count of map.values()) {
        result += count * (count - 1) / 2;
    }

    return result;
}