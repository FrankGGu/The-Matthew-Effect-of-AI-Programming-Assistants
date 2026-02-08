function mazeSolver(maze, entrance) {
    const directions = [[-1, 0], [0, 1], [1, 0], [0, -1]];
    const queue = [];
    const visited = new Set();
    const [startRow, startCol] = entrance;
    queue.push([startRow, startCol, 0]);
    visited.add(`${startRow},${startCol}`);

    while (queue.length > 0) {
        const [row, col, steps] = queue.shift();

        for (const [dr, dc] of directions) {
            const newRow = row + dr;
            const newCol = col + dc;

            if (newRow >= 0 && newRow < maze.length && newCol >= 0 && newCol < maze[0].length) {
                if (maze[newRow][newCol] === '.' && !visited.has(`${newRow},${newCol}`)) {
                    if (newRow === 0 || newRow === maze.length - 1 || newCol === 0 || newCol === maze[0].length - 1) {
                        return steps + 1;
                    }
                    visited.add(`${newRow},${newCol}`);
                    queue.push([newRow, newCol, steps + 1]);
                }
            }
        }
    }

    return -1;
}