function maxOverlap(img1, img2) {
    const n = img1.length;
    const positions1 = [];
    const positions2 = [];

    for (let i = 0; i < n; i++) {
        for (let j = 0; j < n; j++) {
            if (img1[i][j] === 1) {
                positions1.push([i, j]);
            }
            if (img2[i][j] === 1) {
                positions2.push([i, j]);
            }
        }
    }

    const map = new Map();

    for (const [x1, y1] of positions1) {
        for (const [x2, y2] of positions2) {
            const dx = x1 - x2;
            const dy = y1 - y2;
            const key = `${dx},${dy}`;
            map.set(key, (map.get(key) || 0) + 1);
        }
    }

    let max = 0;
    for (const count of map.values()) {
        if (count > max) {
            max = count;
        }
    }

    return max;
}