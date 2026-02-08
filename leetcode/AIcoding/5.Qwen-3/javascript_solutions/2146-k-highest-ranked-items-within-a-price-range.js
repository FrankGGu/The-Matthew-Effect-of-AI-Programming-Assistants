function highestRankedKItems(grid, priceRange, k) {
    const rows = grid.length;
    const cols = grid[0].length;
    const items = [];

    for (let i = 0; i < rows; i++) {
        for (let j = 0; j < cols; j++) {
            if (grid[i][j] >= priceRange[0] && grid[i][j] <= priceRange[1]) {
                items.push({ price: grid[i][j], row: i, col: j });
            }
        }
    }

    items.sort((a, b) => {
        if (a.price !== b.price) return a.price - b.price;
        if (a.row !== b.row) return a.row - b.row;
        return a.col - b.col;
    });

    const result = [];
    for (let i = 0; i < Math.min(k, items.length); i++) {
        result.push([items[i].row, items[i].col]);
    }

    return result;
}