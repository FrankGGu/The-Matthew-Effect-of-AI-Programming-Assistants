function minimumCostHomecoming(row, col, robot, factory) {
    function distance(a, b) {
        return Math.abs(a[0] - b[0]) + Math.abs(a[1] - b[1]);
    }

    robot.sort((a, b) => a[0] - b[0] || a[1] - b[1]);
    factory.sort((a, b) => a[0] - b[0] || a[1] - b[1]);

    let res = 0;
    let r = 0;
    for (let f of factory) {
        while (r < robot.length && distance(robot[r], f) <= distance(robot[r], robot[r + 1])) {
            res += distance(robot[r], f);
            r++;
        }
    }

    return res;
}