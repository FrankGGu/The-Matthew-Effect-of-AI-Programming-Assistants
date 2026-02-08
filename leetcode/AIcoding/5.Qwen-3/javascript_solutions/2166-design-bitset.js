var Bitset = function(size) {
    this.size = size;
    this.bits = new Array(size).fill(0);
    this.count = 0;
};

Bitset.prototype.fix = function(idx) {
    if (this.bits[idx] === 0) {
        this.bits[idx] = 1;
        this.count++;
    }
};

Bitset.prototype.unfix = function(idx) {
    if (this.bits[idx] === 1) {
        this.bits[idx] = 0;
        this.count--;
    }
};

Bitset.prototype.flip = function(idx) {
    if (this.bits[idx] === 0) {
        this.bits[idx] = 1;
        this.count++;
    } else {
        this.bits[idx] = 0;
        this.count--;
    }
};

Bitset.prototype.all = function() {
    return this.count === this.size;
};

Bitset.prototype.one = function() {
    return this.count > 0;
};

Bitset.prototype.count = function() {
    return this.count;
};

Bitset.prototype.toArray = function() {
    return this.bits;
};