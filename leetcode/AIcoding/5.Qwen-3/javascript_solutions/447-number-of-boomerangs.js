var numberOfBoomerangs = function(points) {
    let count = 0;
    for (let i = 0; i < points.length; i++) {
        let map = new Map();
        for (let j = 0; j < points.length; j++) {
            if (i === j) continue;
            let dx = points[i][0] - points[j][0];
            let dy = points[i][1] - points[j][1];
            let dist = dx * dx + dy * dy;
            map.set(dist, (map.get(dist) || 0) + 1);
        }
        for (let v of map.values()) {
            count += v * (v - 1);
        }
    }
    return count;
};