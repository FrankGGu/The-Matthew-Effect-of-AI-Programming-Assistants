function boxReflection(direction, position, time) {
    let x = position[0];
    let y = position[1];
    let dx = direction[0];
    let dy = direction[1];

    while (time > 0) {
        let t = 0;
        if (dx === 1) {
            t = (1 - x) / dx;
        } else if (dx === -1) {
            t = x / dx;
        }
        if (dy === 1) {
            t = Math.min(t, (1 - y) / dy);
        } else if (dy === -1) {
            t = Math.min(t, y / dy);
        }

        if (t === Infinity) break;

        x += dx * t;
        y += dy * t;
        time -= t;

        if (x === 1 || x === 0) {
            dx *= -1;
            x = x === 1 ? 1 : 0;
        }
        if (y === 1 || y === 0) {
            dy *= -1;
            y = y === 1 ? 1 : 0;
        }
    }

    return [x, y];
}