var DataStream = function(data) {
    this.data = data;
    this.index = 0;
};

DataStream.prototype.consecutive = function(k, num) {
    for (let i = 0; i < k; i++) {
        if (this.index + i >= this.data.length || this.data[this.index + i] !== num) {
            return false;
        }
    }
    this.index += k;
    return true;
};