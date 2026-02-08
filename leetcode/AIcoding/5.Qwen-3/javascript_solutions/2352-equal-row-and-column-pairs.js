function equalPairs(grid) {
    const rowMap = new Map();
    const n = grid.length;

    for (let i = 0; i < n; i++) {
        const row = grid[i].join(',');
        rowMap.set(row, (rowMap.get(row) || 0) + 1);
    }

    let count = 0;

    for (let j = 0; j < n; j++) {
        let col = [];
        for (let i = 0; i < n; i++) {
            col.push(grid[i][j]);
        }
        const colStr = col.join(',');
        count += rowMap.get(colStr) || 0;
    }

    return count;
}