var RandomizedSet = function() {
    this.nums = [];
    this.indexMap = new Map();
};

RandomizedSet.prototype.insert = function(val) {
    if (this.indexMap.has(val)) {
        return false;
    }
    this.indexMap.set(val, this.nums.length);
    this.nums.push(val);
    return true;
};

RandomizedSet.prototype.remove = function(val) {
    if (!this.indexMap.has(val)) {
        return false;
    }
    const lastNum = this.nums[this.nums.length - 1];
    const index = this.indexMap.get(val);
    this.nums[index] = lastNum;
    this.indexMap.set(lastNum, index);
    this.indexMap.delete(val);
    this.nums.pop();
    return true;
};

RandomizedSet.prototype.getRandom = function() {
    return this.nums[Math.floor(Math.random() * this.nums.length)];
};