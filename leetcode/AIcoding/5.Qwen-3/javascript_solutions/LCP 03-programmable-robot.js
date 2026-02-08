function robotSim(width, height, robot, obstacles) {
    const directions = [[0, 1], [1, 0], [0, -1], [-1, 0]];
    let dir = 0;
    let x = robot[0];
    let y = robot[1];
    let maxDistance = 0;
    const obstacleSet = new Set(obstacles.map(obstacle => obstacle.join(',')));

    while (true) {
        let newX = x;
        let newY = y;
        let moved = false;

        for (let i = 0; i < 4; i++) {
            const [dx, dy] = directions[(dir + i) % 4];
            const nextX = x + dx;
            const nextY = y + dy;

            if (nextX >= 0 && nextX < width && nextY >= 0 && nextY < height && !obstacleSet.has(`${nextX},${nextY}`)) {
                newX = nextX;
                newY = nextY;
                moved = true;
                dir = (dir + i) % 4;
                break;
            }
        }

        if (!moved) break;

        x = newX;
        y = newY;
        maxDistance = Math.max(maxDistance, x * x + y * y);
    }

    return maxDistance;
}