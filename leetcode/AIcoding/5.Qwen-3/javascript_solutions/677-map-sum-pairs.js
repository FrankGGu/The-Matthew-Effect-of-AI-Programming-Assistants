var MapSum = function() {
    this.map = {};
};

MapSum.prototype.insert = function(key, val) {
    this.map[key] = val;
};

MapSum.prototype.sum = function(prefix) {
    let total = 0;
    for (let key in this.map) {
        if (key.startsWith(prefix)) {
            total += this.map[key];
        }
    }
    return total;
};