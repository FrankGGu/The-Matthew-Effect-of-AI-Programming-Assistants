var NumArray = function(nums) {
    this.prefixSum = [0];
    for (let i = 0; i < nums.length; i++) {
        this.prefixSum.push(this.prefixSum[this.prefixSum.length - 1] + nums[i]);
    }
};

NumArray.prototype.sumRange = function(left, right) {
    return this.prefixSum[right + 1] - this.prefixSum[left];
};