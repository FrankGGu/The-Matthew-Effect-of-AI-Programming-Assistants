function rectangleArea(rectangles) {
    const events = [];
    for (let i = 0; i < rectangles.length; i++) {
        const [x1, y1, x2, y2] = rectangles[i];
        events.push([x1, 'start', y1, y2]);
        events.push([x2, 'end', y1, y2]);
    }
    events.sort((a, b) => a[0] - b[0] || a[1].localeCompare(b[1]));

    let prevX = 0;
    let totalArea = 0;
    const active = [];

    for (const event of events) {
        const [x, type, y1, y2] = event;
        if (prevX !== 0 && x !== prevX) {
            let height = 0;
            active.sort((a, b) => a[0] - b[0]);
            let current = -1;
            for (const [yStart, yEnd] of active) {
                if (yStart > current) {
                    height += yEnd - yStart;
                    current = yEnd;
                } else {
                    current = Math.max(current, yEnd);
                }
            }
            totalArea += (x - prevX) * height;
        }
        if (type === 'start') {
            active.push([y1, y2]);
        } else {
            active.splice(active.findIndex(e => e[0] === y1 && e[1] === y2), 1);
        }
        prevX = x;
    }

    return totalArea;
}