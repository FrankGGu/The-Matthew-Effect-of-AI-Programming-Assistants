var Solution = function(w) {
    this.prefixSums = [];
    let sum = 0;
    for (let i = 0; i < w.length; i++) {
        sum += w[i];
        this.prefixSums.push(sum);
    }
};

Solution.prototype.pickIndex = function() {
    const total = this.prefixSums[this.prefixSums.length - 1];
    const randomNum = Math.random() * total;
    let left = 0;
    let right = this.prefixSums.length - 1;
    while (left < right) {
        const mid = Math.floor((left + right) / 2);
        if (randomNum >= this.prefixSums[mid]) {
            left = mid + 1;
        } else {
            right = mid;
        }
    }
    return left;
};