var Spreadsheet = function() {
    this.data = {};
};

Spreadsheet.prototype.set = function(row, col, val) {
    if (!this.data[row]) {
        this.data[row] = {};
    }
    this.data[row][col] = val;
};

Spreadsheet.prototype.get = function(row, col) {
    return this.data[row] && this.data[row][col] !== undefined ? this.data[row][col] : 0;
};

Spreadsheet.prototype.sum = function(row, col, cells) {
    let sum = 0;
    for (let cell of cells) {
        const [r, c] = cell.split(':');
        if (this.data[r] && this.data[r][c] !== undefined) {
            sum += this.data[r][c];
        } else {
            sum += 0;
        }
    }
    if (!this.data[row]) {
        this.data[row] = {};
    }
    this.data[row][col] = sum;
    return sum;
};