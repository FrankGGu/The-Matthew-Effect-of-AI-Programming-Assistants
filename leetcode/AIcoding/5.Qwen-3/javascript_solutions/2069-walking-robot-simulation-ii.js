var robotSim = function(commands, obstacles) {
    const dir = [[0, 1], [1, 0], [0, -1], [-1, 0]];
    let x = 0, y = 0, d = 0;
    let maxDistance = 0;
    const obstacleSet = new Set();
    for (const [ox, oy] of obstacles) {
        obstacleSet.add(ox + ',' + oy);
    }
    for (const command of commands) {
        if (command === 9) {
            d = (d + 1) % 4;
        } else {
            for (let i = 0; i < command; i++) {
                const nx = x + dir[d][0];
                const ny = y + dir[d][1];
                const key = nx + ',' + ny;
                if (obstacleSet.has(key)) break;
                x = nx;
                y = ny;
                maxDistance = Math.max(maxDistance, x * x + y * y);
            }
        }
    }
    return maxDistance;
};