function minMovesToCleanTheClassroom(classroom) {
    const m = classroom.length;
    const n = classroom[0].length;
    const directions = [[-1, 0], [1, 0], [0, -1], [0, 1]];
    let queue = [];
    let visited = Array.from({ length: m }, () => Array(n).fill(false));

    for (let i = 0; i < m; i++) {
        for (let j = 0; j < n; j++) {
            if (classroom[i][j] === 'M') {
                queue.push([i, j, 0]);
                visited[i][j] = true;
            }
        }
    }

    while (queue.length > 0) {
        const [i, j, steps] = queue.shift();

        for (const [dx, dy] of directions) {
            const ni = i + dx;
            const nj = j + dy;

            if (ni >= 0 && ni < m && nj >= 0 && nj < n && !visited[ni][nj]) {
                if (classroom[ni][nj] === 'O') {
                    return steps + 1;
                }
                visited[ni][nj] = true;
                queue.push([ni, nj, steps + 1]);
            }
        }
    }

    return -1;
}