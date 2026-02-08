function findFarmland(land) {
    const m = land.length;
    const n = land[0].length;
    const result = [];

    for (let i = 0; i < m; i++) {
        for (let j = 0; j < n; j++) {
            if (land[i][j] === 1 && (i === 0 || land[i-1][j] === 0) && (j === 0 || land[i][j-1] === 0)) {
                let x = i;
                while (x + 1 < m && land[x+1][j] === 1) x++;
                let y = j;
                while (y + 1 < n && land[i][y+1] === 1) y++;
                result.push([i, j, x, y]);
            }
        }
    }

    return result;
}