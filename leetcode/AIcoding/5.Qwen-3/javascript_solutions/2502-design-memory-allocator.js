var Allocator = function(n) {
    this.memory = new Array(n).fill(0);
};

Allocator.prototype.allocate = function(size, startIdx) {
    let i = startIdx;
    while (i < this.memory.length && this.memory[i] === 0) {
        i++;
    }
    if (i - startIdx >= size) {
        for (let j = startIdx; j < startIdx + size; j++) {
            this.memory[j] = 1;
        }
        return startIdx;
    }
    return -1;
};

Allocator.prototype.free = function(startIdx) {
    for (let i = startIdx; i < this.memory.length && this.memory[i] === 1; i++) {
        this.memory[i] = 0;
    }
};

Allocator.prototype.occupied = function() {
    return this.memory.filter(v => v === 1).length;
};