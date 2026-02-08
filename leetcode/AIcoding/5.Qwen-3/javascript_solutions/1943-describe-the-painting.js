function drawPainting(segments) {
    const events = [];

    for (const [start, end, color] of segments) {
        events.push([start, color, 'start']);
        events.push([end, color, 'end']);
    }

    events.sort((a, b) => {
        if (a[0] !== b[0]) return a[0] - b[0];
        if (a[2] === b[2]) return 0;
        return a[2] === 'start' ? -1 : 1;
    });

    const result = [];
    let prev = -1;
    const colorSet = new Set();

    for (const [pos, color, type] of events) {
        if (prev !== -1 && pos > prev && colorSet.size > 0) {
            const colors = Array.from(colorSet);
            result.push([prev, pos, colors]);
        }

        if (type === 'start') {
            colorSet.add(color);
        } else {
            colorSet.delete(color);
        }

        prev = pos;
    }

    return result;
}