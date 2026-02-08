function passThePillow(n, time) {
    let direction = 1;
    let current = 1;
    for (let i = 0; i < time; i++) {
        if (current === n) {
            direction = -1;
        } else if (current === 1) {
            direction = 1;
        }
        current += direction;
    }
    return current;
}