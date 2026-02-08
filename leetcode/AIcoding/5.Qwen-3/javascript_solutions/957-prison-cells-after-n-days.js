function prisonAfterNDays(cells, n) {
    const nextDay = (cells) => {
        const newCells = new Array(8).fill(0);
        for (let i = 1; i < 7; i++) {
            newCells[i] = cells[i - 1] === cells[i + 1] ? 1 : 0;
        }
        return newCells;
    };

    const getKey = (cells) => cells.join(',');

    const seen = {};
    let day = 0;

    while (day < n) {
        const key = getKey(cells);
        if (seen.hasOwnProperty(key)) {
            const cycle = day - seen[key];
            n = (n - day) % cycle;
            day = n;
        } else {
            seen[key] = day;
        }

        if (day < n) {
            cells = nextDay(cells);
        }
        day++;
    }

    return cells;
}