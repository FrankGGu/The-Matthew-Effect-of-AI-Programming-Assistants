var Solution = function(rects) {
    this.rects = rects;
    this.prefixSums = [];
    for (let i = 0; i < rects.length; i++) {
        const [x1, y1, x2, y2] = rects[i];
        const area = (x2 - x1 + 1) * (y2 - y1 + 1);
        this.prefixSums.push(area + (this.prefixSums.length > 0 ? this.prefixSums[this.prefixSums.length - 1] : 0));
    }
};

Solution.prototype.pick = function() {
    const total = this.prefixSums[this.prefixSums.length - 1];
    const rand = Math.random() * total;
    let left = 0, right = this.prefixSums.length - 1;
    while (left < right) {
        const mid = Math.floor((left + right) / 2);
        if (rand >= this.prefixSums[mid]) {
            left = mid + 1;
        } else {
            right = mid;
        }
    }
    const [x1, y1, x2, y2] = this.rects[left];
    const x = Math.floor(Math.random() * (x2 - x1 + 1)) + x1;
    const y = Math.floor(Math.random() * (y2 - y1 + 1)) + y1;
    return [x, y];
};