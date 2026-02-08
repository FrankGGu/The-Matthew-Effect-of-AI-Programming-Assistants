function trapRainWater(heightMap) {
    if (!heightMap || heightMap.length < 3 || heightMap[0].length < 3) return 0;

    const m = heightMap.length;
    const n = heightMap[0].length;
    const visited = new Array(m).fill(0).map(() => new Array(n).fill(false));
    const heap = [];

    for (let i = 0; i < m; i++) {
        for (let j = 0; j < n; j++) {
            if (i === 0 || i === m - 1 || j === 0 || j === n - 1) {
                heap.push([heightMap[i][j], i, j]);
                visited[i][j] = true;
            }
        }
    }

    heap.sort((a, b) => a[0] - b[0]);

    const dirs = [[-1, 0], [1, 0], [0, -1], [0, 1]];
    let result = 0;

    while (heap.length > 0) {
        const [h, x, y] = heap.shift();
        for (const [dx, dy] of dirs) {
            const nx = x + dx;
            const ny = y + dy;
            if (nx >= 0 && nx < m && ny >= 0 && ny < n && !visited[nx][ny]) {
                visited[nx][ny] = true;
                result += Math.max(0, h - heightMap[nx][ny]);
                heap.push([Math.max(h, heightMap[nx][ny]), nx, ny]);
                heap.sort((a, b) => a[0] - b[0]);
            }
        }
    }

    return result;
}