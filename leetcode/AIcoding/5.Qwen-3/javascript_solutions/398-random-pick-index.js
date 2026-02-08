var Solution = function(nums) {
    this.nums = nums;
};

Solution.prototype.pick = function(target) {
    var index = -1;
    var count = 0;
    for (var i = 0; i < this.nums.length; i++) {
        if (this.nums[i] === target) {
            count++;
            if (Math.random() < 1 / count) {
                index = i;
            }
        }
    }
    return index;
};