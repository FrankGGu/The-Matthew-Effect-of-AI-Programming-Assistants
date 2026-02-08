function Solution(weights) {
    this.prefixSums = [];
    let sum = 0;
    for (let weight of weights) {
        sum += weight;
        this.prefixSums.push(sum);
    }
}

Solution.prototype.pickIndex = function() {
    const target = Math.random() * this.prefixSums[this.prefixSums.length - 1];
    let left = 0;
    let right = this.prefixSums.length - 1;
    while (left < right) {
        const mid = Math.floor((left + right) / 2);
        if (target > this.prefixSums[mid]) {
            left = mid + 1;
        } else {
            right = mid;
        }
    }
    return left;
};