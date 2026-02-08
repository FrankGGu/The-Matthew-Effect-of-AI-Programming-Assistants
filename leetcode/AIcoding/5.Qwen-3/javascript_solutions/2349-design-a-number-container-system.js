var NumberContainer = function() {
    this.map = new Map();
    this.sortedIndices = new Set();
};

NumberContainer.prototype.change = function(index, number) {
    this.map.set(index, number);
    this.sortedIndices.add(index);
};

NumberContainer.prototype.find = function(index) {
    return this.map.get(index);
};

NumberContainer.prototype.getAll = function() {
    const result = [];
    for (const [key, value] of this.map.entries()) {
        result.push([key, value]);
    }
    return result;
};