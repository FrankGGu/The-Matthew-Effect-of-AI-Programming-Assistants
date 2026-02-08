function countRectangles(rectangles, points) {
    const map = new Map();
    for (const [x, y] of rectangles) {
        if (!map.has(x)) map.set(x, []);
        map.get(x).push(y);
    }
    for (const key of map.keys()) {
        map.get(key).sort((a, b) => a - b);
    }
    const res = [];
    for (const [x, y] of points) {
        let count = 0;
        for (const key of map.keys()) {
            if (key >= x) {
                const ys = map.get(key);
                let low = 0, high = ys.length - 1;
                while (low <= high) {
                    const mid = Math.floor((low + high) / 2);
                    if (ys[mid] >= y) high = mid - 1;
                    else low = mid + 1;
                }
                count += ys.length - low;
            }
        }
        res.push(count);
    }
    return res;
}