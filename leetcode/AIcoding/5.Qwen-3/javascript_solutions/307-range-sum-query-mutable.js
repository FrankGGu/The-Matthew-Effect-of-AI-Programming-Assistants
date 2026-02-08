var NumArray = function(nums) {
    this.nums = nums;
    this.tree = new Array(nums.length + 1).fill(0);
    for (let i = 0; i < nums.length; i++) {
        this.updateTree(i, nums[i]);
    }
};

NumArray.prototype.updateTree = function(index, value) {
    index += 1;
    while (index < this.tree.length) {
        this.tree[index] += value;
        index += index & -index;
    }
};

NumArray.prototype.queryTree = function(index) {
    index += 1;
    let sum = 0;
    while (index > 0) {
        sum += this.tree[index];
        index -= index & -index;
    }
    return sum;
};

NumArray.prototype.update = function(index, value) {
    const diff = value - this.nums[index];
    this.nums[index] = value;
    this.updateTree(index, diff);
};

NumArray.prototype.sumRange = function(left, right) {
    return this.queryTree(right) - this.queryTree(left - 1);
};